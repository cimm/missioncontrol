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

  it "belongs to a client" do
    unit.should respond_to :client
    unit.should respond_to :client=
  end

  it "isn't valid without a client" do
    unit.client = nil
    unit.should_not be_valid
  end

  describe "client_nickname" do
    let(:client)   { mock("Client") }
    let(:nickname) { mock("Nickname") }

    before :each do
      unit.stub(:client => client)
      client.stub(:nickname => nickname)
    end

    it "gets the client" do
      unit.should_receive(:client).and_return(client)
      unit.client_nickname
    end

    it "gets the nickname from the client" do
      client.should_receive(:nickname).and_return(nickname)
      unit.client_nickname
    end

    it "returns the client's nickname" do
      unit.client_nickname.should eql nickname
    end
  end
end
