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

  it "has a nickname" do
    client.should respond_to :nickname
    client.should respond_to :nickname=
  end

  it "isn't valid without a nickname" do
    client.nickname = nil
    client.should_not be_valid
  end

  it "has a name" do
    client.should respond_to :name
    client.should respond_to :name=
  end
end
