require "spec_helper"

describe NavigationHelper do
  describe "active" do
    let(:page)            { mock("Name of the page") }
    let(:controller_name) { mock("Name of the current controller") }
    let(:params)          { {:controller => controller_name} }

    before :each do
      helper.stub(:params => params)
    end

    context "for the current page" do
      it "returns active" do
        params[:controller] = page
        helper.active(page).should eql "active"
      end
    end

    context "for any other page" do
      it "returns nil" do
        helper.active(page).should eql nil
      end
    end
  end
end
