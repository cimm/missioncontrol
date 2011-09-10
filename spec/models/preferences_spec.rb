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
end
