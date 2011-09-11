require "spec_helper"

describe "preferences/_form" do
  let(:preference)        { mock_model(Preference) }
  let(:setting)           { "vat_number" }
  let(:humanized_setting) { "Vat number" }
  let(:partial_render)    { render :partial => "preferences/form", :object => @form }

  before :each do
    preference.stub(:setting => setting, :value => nil)
    setting.stub(:humanize => humanized_setting)
    form_for(preference) { |f| @form = f }
  end

  it "gets the setting from the preference" do
    preference.should_receive(:setting)
    partial_render
  end

  it "humanizes the setting" do
    setting.should_receive(:humanize)
    partial_render
  end

  it "has a label for the value field" do
    partial_render
    rendered.should have_content(humanized_setting)
  end

  it "has a value text field" do
    partial_render
    rendered.should have_selector("#preference_value")
  end
end
