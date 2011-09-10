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

describe "preferences/edit" do
  let(:preference)        { mock_model(Preference) }
  let(:setting)           { "vat_number" }
  let(:humanized_setting) { "Vat number" }

  before :each do
    preference.stub(:setting => setting, :value => nil)
    assign :preference, preference
  end

  it "has a title" do
    render
    rendered.should have_content("Edit preference")
  end

  it "gets the settings from the preference" do
    preference.should_receive(:setting)
    render
  end

  it "humanizes the setting" do
    setting.should_receive(:humanize)
    render
  end

  it "has a label for the value field" do
    render
    rendered.should have_content(preference.setting.humanize)
  end

  it "has a value text field" do
    render
    rendered.should have_selector("#preference_value")
  end

  it "has a submit button to update the preference" do
    render
    rendered.should have_button("Update preference")
  end

  it "has a cancel link" do
    render
    rendered.should have_link("cancel")
  end
end
