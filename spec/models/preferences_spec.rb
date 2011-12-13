require "spec_helper"

describe Preference do
  let(:preference) { FactoryGirl.build(:preference) }

  it "has a creation date" do
    preference.should respond_to :created_at
    preference.should respond_to :created_at=
  end

  it "has an updated date" do
    preference.should respond_to :updated_at
    preference.should respond_to :updated_at=
  end

  it "has a setting" do
    preference.should respond_to :setting
    preference.should respond_to :setting=
  end

  it "isn't valid without a setting" do
    preference.setting = nil
    preference.should_not be_valid
  end

  it "has a value" do
    preference.should respond_to :value
    preference.should respond_to :value=
  end

  describe "value_of" do
    let(:setting) { mock("Preference setting") }
    let(:value)   { mock("Preference value") }

    before :each do
      Preference.stub(:find_by_setting => setting)
      setting.stub(:value => value)
    end

    it "finds the setting" do
      Preference.should_receive(:find_by_setting)
      Preference.value_of(setting)
    end

    context "setting does exist" do
      it "gets the value of the setting" do
        setting.should_receive(:value)
        Preference.value_of(setting)
      end

      it "returns this value" do
        Preference.value_of(setting).should eql value
      end
    end

    context "setting does not exist" do
      before :each do
        Preference.stub(:find_by_setting => nil)
      end

      it "returns 0" do
        Preference.value_of(setting).should eql "0"
      end
    end
  end
end
