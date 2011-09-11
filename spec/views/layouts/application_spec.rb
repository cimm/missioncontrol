require "spec_helper"

describe "layouts/application" do
  let(:flash) { mock("Flash") }

  before :each do
    stub_template("layouts/_navigation" => "", "layouts/_flash" => "")
  end

  it "renders the navigation partial" do
    render
    view.should render_template(:partial => "layouts/_navigation")
  end

  it "renders the flash partial" do
    render
    view.should render_template(:partial => "layouts/_flash", :object => flash)
  end
end
