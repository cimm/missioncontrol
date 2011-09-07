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

  it "belongs to a project" do
    unit.should respond_to :project
    unit.should respond_to :project=
  end

  it "isn't valid without a project" do
    unit.project = nil
    unit.should_not be_valid
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
end
