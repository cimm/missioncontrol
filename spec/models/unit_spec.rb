require "spec_helper"

describe Unit do
  let(:unit) { FactoryGirl.build(:unit) }

  it "has a creation date" do
    unit.should respond_to :created_at
    unit.should respond_to :created_at=
  end
end
