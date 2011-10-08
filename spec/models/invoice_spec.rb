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

    before :each do
      invoice.stub(:units => units)
      Unit.stub(:not_invoiced => units_not_invoiced)
      units.stub(:+ => selectable_units)
      selectable_units[0].stub(:executed_at => Date.today-1)
      selectable_units[1].stub(:executed_at => Date.today)
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
end
