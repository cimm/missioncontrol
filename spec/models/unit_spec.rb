require "spec_helper"

describe Unit do
  let(:unit) { FactoryGirl.build(:unit) }

  it "has an execution date" do
    unit.should respond_to :executed_at
    unit.should respond_to :executed_at=
  end

  it "has a creation date" do
    unit.should respond_to :created_at
    unit.should respond_to :created_at=
  end

  it "has an updated date" do
    unit.should respond_to :updated_at
    unit.should respond_to :updated_at=
  end

  it "isn't valid without an execution date" do
    unit.executed_at = nil
    unit.should_not be_valid
  end
end
