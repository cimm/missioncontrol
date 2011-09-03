require "spec_helper"

describe Project do
  let(:project) { FactoryGirl.build(:project) }

  it "has a creation date" do
    project.should respond_to :created_at
    project.should respond_to :created_at=
  end

  it "has an updated date" do
    project.should respond_to :updated_at
    project.should respond_to :updated_at=
  end

  it "has a name" do
    project.should respond_to :name
    project.should respond_to :name=
  end

  it "isn't valid without a name" do
    project.name = nil
    project.should_not be_valid
  end

  it "belongs to a client" do
    project.should respond_to :client
    project.should respond_to :client=
  end

  it "isn't valid without a client" do
    project.client = nil
    project.should_not be_valid
  end
end
