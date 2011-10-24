require "spec_helper"

describe Unit do
  let(:unit) { FactoryGirl.build(:unit) }

  it "has a creation date" do
    unit.should respond_to :created_at
    unit.should respond_to :created_at=
  end

  it "has an updated date" do
    unit.should respond_to :updated_at
    unit.should respond_to :updated_at=
  end

  it "has an execution date" do
    unit.should respond_to :executed_at
    unit.should respond_to :executed_at=
  end

  it "isn't valid without an execution date" do
    unit.executed_at = nil
    unit.should_not be_valid
  end

  it "has the hours spent" do
    unit.should respond_to :hours_spent
    unit.should respond_to :hours_spent=
  end

  it "isn't valid without the hours spent" do
    unit.hours_spent = nil
    unit.should_not be_valid
  end

  it "isn't valid when more than 24 hours have been spent" do
    unit.hours_spent = 25
    unit.should_not be_valid
  end

  it "isn't valid when zero hours have been spent" do
    unit.hours_spent = 0
    unit.should_not be_valid
  end

  it "belongs to a project" do
    unit.should respond_to :project
    unit.should respond_to :project=
  end

  it "isn't valid without a project" do
    unit.project = nil
    unit.should_not be_valid
  end

  it "belongs to an invoice" do
    unit.should respond_to :invoice
    unit.should respond_to :invoice=
  end

  context "self.not_invoiced" do
    let(:invoiced_unit)      { mock("Invoiced unit") }
    let(:units)              { [unit, invoiced_unit] }
    let(:units_not_invoiced) { [unit] }

    before :each do
      Unit.stub(:all => units)
      unit.stub(:invoiced? => false)
      invoiced_unit.stub(:invoiced? => true)
    end

    it "gets the all the units" do
      Unit.should_receive(:all)
      Unit.not_invoiced
    end

    it "checks if the units are invoiced" do
      units.each do |u|
        u.should_receive(:invoiced?)
      end
      Unit.not_invoiced
    end

    it "returns the units that aren't invoiced yet" do
      Unit.not_invoiced.should eql units_not_invoiced
    end
  end

  describe "project_name" do
    let(:project) { mock("Project") }
    let(:name)    { mock("Name") }

    before :each do
      unit.stub(:project => project)
      project.stub(:name => name)
    end

    it "gets the project" do
      unit.should_receive(:project).and_return(project)
      unit.project_name
    end

    it "gets the name from the project" do
      project.should_receive(:name).and_return(name)
      unit.project_name
    end

    it "returns the project's name" do
      unit.project_name.should eql name
    end
  end

  describe "invoiced?" do
    it "gets the invoice" do
      unit.should_receive(:invoice)
      unit.invoiced?
    end

    context "it has an invoice" do
      before :each do
        unit.stub(:invoice => mock("Invoice"))
      end

      it "returns true" do
        unit.should be_invoiced
      end
    end

    context "it does not have an invoice" do
      before :each do
        unit.stub(:invoice => nil)
      end

      it "returns false" do
        unit.should_not be_invoiced
      end
    end
  end

  describe "cost" do
    let(:project)      { mock("Project") }
    let(:default_rate) { mock("Default rate") }

    before :each do
      unit.stub(:project => project)
      project.stub(:default_rate => default_rate)
    end

    it "gets the linked project" do
      unit.should_receive(:project)
      unit.cost
    end

    it "gets the default project rate" do
      project.should_receive(:default_rate)
      unit.cost
    end

    context "linked project has a default rate" do
      it "returns the unit cost" do
        unit.cost.should eql default_rate
      end
    end

    context "linked project does not have a default rate" do
      before :each do
        project.stub(:default_rate => nil)
      end

      it "returns 0" do
        unit.cost.should eql 0
      end
    end
  end
end
