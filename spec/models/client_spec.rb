require "spec_helper"

describe Client do
  let(:client) { FactoryGirl.build(:client) }

  it "has a creation date" do
    client.should respond_to :created_at
    client.should respond_to :created_at=
  end

  it "has an updated date" do
    client.should respond_to :updated_at
    client.should respond_to :updated_at=
  end
end
