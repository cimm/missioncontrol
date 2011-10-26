require "spec_helper"

describe Invoice do
  let(:invoice) { FactoryGirl.build(:invoice) }

  it "has a creation date" do
    invoice.should respond_to :created_at
    invoice.should respond_to :created_at=
  end

  it "has an updated date" do
    invoice.should respond_to :updated_at
    invoice.should respond_to :updated_at=
  end

  it "has a number" do
    invoice.should respond_to :number
    invoice.should respond_to :number=
  end

  it "has a unique number" do
    older_invoice  = FactoryGirl.create(:invoice)
    invoice.number = older_invoice.number
    invoice.should_not be_valid
  end

  it "is not valid without a number" do
    invoice.number = nil
    invoice.should_not be_valid
  end

  it "has many units" do
    invoice.should respond_to :units
    invoice.should respond_to :units=
  end

  it "has many projects" do
    invoice.should respond_to :projects
    invoice.should respond_to :projects=
  end

  it "only returns unique projects" do
    project       = FactoryGirl.build(:project)
    invoice.units = [FactoryGirl.build(:unit, :project => project), FactoryGirl.build(:unit, :project => project)]
    invoice.save!
    invoice.projects.count.should be 1
  end

  it "has many clients" do
    invoice.should respond_to :clients
    invoice.should respond_to :clients=
  end

  it "only returns unique clients" do
    project       = FactoryGirl.build(:project)
    invoice.units = [FactoryGirl.build(:unit, :project => project), FactoryGirl.build(:unit, :project => project)]
    invoice.save!
    invoice.clients.count.should be 1
  end

  it "has a payed at date" do
    invoice.should respond_to :payed_at
    invoice.should respond_to :payed_at=
  end

  it "has an owed at date" do
    invoice.should respond_to :owed_at
    invoice.should respond_to :owed_at=
  end

  describe "self.next_number" do
    let(:previous_invoice_number) { mock("Previous invoice number") }
    let(:next_invoice_number)     { mock("Next invoice number") }

    before :each do
      Invoice.stub(:maximum => previous_invoice_number)
      previous_invoice_number.stub(:+ => next_invoice_number)
    end

    it "gets the highest invoice number" do
      Invoice.should_receive(:maximum).with(:number)
      Invoice.next_number
    end

    context "there are other invoices" do
      it "calculates the next number" do
        previous_invoice_number.should_receive(:+).with(1)
        Invoice.next_number
      end

      it "returns the next number" do
        Invoice.next_number.should eql next_invoice_number
      end
    end

    context "there are no other invoices" do
      let(:previous_invoice_number) do
        allow_message_expectations_on_nil
        nil
      end

      it "returns 1 as the next number" do
        Invoice.next_number.should eql 1
      end
    end
  end

  describe "selectable_units" do
    let(:units)              { [mock("Unit")] }
    let(:units_not_invoiced) { [mock("Unit")] }
    let(:selectable_units)   { [mock("Unit"), mock("Unit")] }
    let(:yesterday)          { Date.today - 1 }
    let(:today)              { Date.today }

    before :each do
      invoice.stub(:units => units)
      Unit.stub(:not_invoiced => units_not_invoiced)
      units.stub(:+ => selectable_units)
      selectable_units[0].stub(:executed_at => yesterday)
      selectable_units[1].stub(:executed_at => today)
    end

    it "gets the units linked to the invoice" do
      invoice.should_receive(:units)
      invoice.selectable_units
    end

    it "gets the units that aren't invoiced yet" do
      Unit.should_receive(:not_invoiced)
      invoice.selectable_units
    end

    it "combines the units that aren't invoiced with the ones linked to the invoice" do
      units.should_receive(:+).with(units_not_invoiced)
      invoice.selectable_units
    end

    it "gets the date each unit was executed" do
      selectable_units.each do |u|
        u.should_receive(:executed_at)
      end
      invoice.selectable_units
    end

    it "returns the sorted selectable units" do
      invoice.selectable_units.should eql selectable_units
    end
  end

  describe "has_invoiced_unit?" do
    let(:unit)  { mock("Unit") }
    let(:units) { [unit] }

    before :each do
      invoice.stub(:units => units)
    end

    it "gets the units for the invoice" do
      invoice.should_receive(:units)
      invoice.has_invoiced_unit?(unit)
    end

    context "unit has been invoiced on the invoice" do
      it "returns true" do
        invoice.should have_invoiced_unit(unit)
      end
    end

    context "unit has not been invoiced on the invoice" do
      before :each do
        invoice.stub(:units => [])
      end

      it "returns false" do
        invoice.should_not have_invoiced_unit(unit)
      end
    end
  end

  describe "overdue?" do
    let(:today) { Date.today }

    before :each do
      invoice.stub(:owed_at => today)
    end

    it "checks if the invoice has been payed" do
      invoice.should_receive(:payed?)
      invoice.overdue?
    end

    it "checks if the invoice owed date has passed" do
      invoice.should_receive(:has_passed_its_owed_date?)
      invoice.overdue?
    end

    context "has been payed" do
      before :each do
        invoice.stub(:payed? => true)
      end

      it "returns false" do
        invoice.should_not be_overdue
      end
    end

    context "did not pass the owed date" do
      before :each do
        invoice.stub(:payed? => false, :has_passed_its_owed_date? => false)
      end

      it "returns false" do
        invoice.should_not be_overdue
      end
    end

    context "did pass the owed date" do
      before :each do
        invoice.stub(:payed? => false, :has_passed_its_owed_date? => true)
      end

      it "returns true" do
        invoice.should be_overdue
      end
    end
  end

  describe "has_passed_its_owed_date?" do
    let(:yesterday) { Date.today - 1}
    let(:today)     { Date.today }
    let(:tomorrow)  { Date.today + 1 }

    it "gets the date the invoice is owed at" do
      invoice.should_receive(:owed_at)
      invoice.has_passed_its_owed_date?
    end

    it "gets today's date" do
      Date.should_receive(:today).and_return(today)
      invoice.has_passed_its_owed_date?
    end

    context "has no owed date" do
      before :each do
        invoice.stub(:owed_at => nil)
      end

      it "returns false" do
        invoice.should_not have_passed_its_owed_date
      end
    end

    context "owed date passed" do
      before :each do
        invoice.stub(:owed_at => yesterday)
      end

      it "returns true" do
        invoice.should have_passed_its_owed_date
      end
    end

    context "owed date not passed" do
      before :each do
        invoice.stub(:owed_at => tomorrow)
      end

      it "returns false" do
        invoice.should_not have_passed_its_owed_date
      end
    end
  end

  describe "payed?" do
    let(:today) { Date.today }

    it "gets the date the invoice was payed" do
      invoice.should_receive(:payed_at)
      invoice.payed?
    end

    context "has been payed" do
      before :each do
        invoice.stub(:payed_at => today)
      end

      it "returns true" do
        invoice.should be_payed
      end
    end

    context "has not been payed yet" do
      before :each do
        invoice.stub(:payed_at => nil)
      end

      it "returns false" do
        invoice.should_not be_payed
      end
    end
  end

  describe "cost_per_unit" do
    let(:units)       { [mock("Unit")] }
    let(:cost)        { mock("Cost") }
    let(:units_costs) { [cost] }

    before :each do
      invoice.stub(:units => units)
      units.each do |u|
        u.stub(:cost => cost)
      end
    end

    it "gets all linked units" do
      invoice.should_receive(:units)
      invoice.cost_per_unit
    end

    it "gets the cost for the each unit" do
      units.each do |u|
        u.should_receive(:cost)
      end
      invoice.cost_per_unit
    end

    it "returns the a list of unit costs" do
      invoice.cost_per_unit.should eql units_costs
    end
  end

  describe "total_amount_before_vat" do
    let(:cost_per_unit)    { [300, 200] }
    let(:total_units_cost) { 500 }

    before :each do
      invoice.stub(:cost_per_unit => cost_per_unit)
    end

    it "gets the costs per unit" do
      invoice.should_receive(:cost_per_unit)
      invoice.total_amount_before_vat
    end

    it "returns the sum of all unit costs" do
      invoice.total_amount_before_vat.should eql total_units_cost
    end
  end

  describe "clients_nicknames" do
    let(:client)            { mock("Client") }
    let(:clients)           { [client] }
    let(:nickname)          { mock("Nickname") }
    let(:clients_nicknames) { [nickname] }

    before :each do
      invoice.stub(:clients => clients)
      client.stub(:nickname => nickname)
    end

    it "gets the clients" do
      invoice.should_receive(:clients)
      invoice.clients_nicknames
    end

    it "gets the nicknames of the clients" do
      clients.each do |c|
        c.should_receive(:nickname)
      end
      invoice.clients_nicknames
    end

    it "returns the nicknames of the clients" do
      invoice.clients_nicknames.should eql clients_nicknames
    end
  end
end
