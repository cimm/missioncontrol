require "spec_helper"

describe "preferences/index" do
  let(:preference)        { mock_model(Preference) }
  let(:preferences)       { [preference] }
  let(:setting)           { "vat_number" }
  let(:humanized_setting) { "Vat number" }
  let(:value)             { "BE0437262043" }

  before :each do
    preference.stub(:setting => setting, :value => value)
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
    rendered.should have_tag("th", :text => /#{humanized_setting}/i)
  end

  it "gets the values from the preferences" do
    preferences.each do |p|
      p.should_receive(:value)
    end
    render
  end

  it "shows the values" do
    render
    rendered.should have_tag("td", :with => {:class => "value"}, :text => /#{value}/i)
  end

  it "shows an edit link for the preferences" do
    render
    rendered.should have_selector("a#edit_preference_#{preference.id}")
  end
end
