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

  it "has a default rate" do
    project.should respond_to :default_rate
    project.should respond_to :default_rate=
  end

  it "is valid with a decimal default rate" do
    project.default_rate = 400.50
    project.should be_valid
  end

  it "isn't valid with a negative default rate" do
    project.default_rate = -500
    project.should_not be_valid
  end

  describe "client_nickname" do
    let(:client)   { mock("Client") }
    let(:nickname) { mock("Nickname") }

    before :each do
      project.stub(:client => client)
      client.stub(:nickname => nickname)
    end

    it "gets the client" do
      project.should_receive(:client).and_return(client)
      project.client_nickname
    end

    it "gets the nickname from the client" do
      client.should_receive(:nickname).and_return(nickname)
      project.client_nickname
    end

    it "returns the client's nickname" do
      project.client_nickname.should eql nickname
    end
  end
end
