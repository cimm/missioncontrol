require "spec_helper"

describe "preferences/index" do
  let(:preference)        { mock_model(Preference) }
  let(:preferences)       { [preference] }
  let(:setting)           { mock("Key for setting") }
  let(:humanized_setting) { mock("Humanized key for setting") }
  let(:value)             { mock("Value for setting") }

  before :each do
    preference.stub(:setting => setting, :value => value)
    setting.stub(:humanize => humanized_setting)
    assign :preferences, preferences
  end

  it "has a title" do
    render
    rendered.should have_content("Preferences")
  end

  it "gets the settings from the preferences" do
    preferences.each do |p|
      p.should_receive(:setting)
    end
    render
  end

  it "humanizes the settings" do
    preferences.each do |p|
      setting.should_receive(:humanize)
    end
    render
  end

  it "shows the settings" do
    render
    rendered.should have_tag("th", :text => humanized_setting)
  end

  it "gets the values from the preferences" do
    preferences.each do |p|
      p.should_receive(:value)
    end
    render
  end

  it "shows the values" do
    render
    rendered.should have_tag(".value", :text => value)
  end

  it "shows an edit link for the preferences" do
    render
    rendered.should have_selector("a#edit_preference_#{preference.id}")
  end
end
