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

  describe "fiscal_quarter_path" do
    let(:quarter)             { mock("Quarter") }
    let(:fiscal_quarter)      { mock("Fiscal quarter") }
    let(:starts_at)           { mock("Starts at") }
    let(:ends_at)             { mock("Ends at") }
    let(:date_range)          { "#{starts_at}to#{ends_at}" }
    let(:fiscal_quarter_path) { mock("Fiscal quarter path") }

    before :each do
      FiscalQuarter.stub(:new => fiscal_quarter)
      fiscal_quarter.stub(:starts_at => starts_at, :ends_at => ends_at)
      helper.stub(:expenses_path => fiscal_quarter_path)
    end

    it "gets creates a new fiscal quarter for the given quarter" do
      FiscalQuarter.should_receive(:new).with(quarter)
      helper.fiscal_quarter_path(quarter)
    end

    it "gets the start date from the fiscal quarter" do
      fiscal_quarter.should_receive(:starts_at)
      helper.fiscal_quarter_path(quarter)
    end

    it "gets the end date from the fiscal quarter" do
      fiscal_quarter.should_receive(:ends_at)
      helper.fiscal_quarter_path(quarter)
    end

    it "builds the expenses path with the data range" do
      helper.should_receive(:expenses_path).with(:date_range => date_range)
      helper.fiscal_quarter_path(quarter)
    end

    it "returns the expenses path with the date range" do
      helper.fiscal_quarter_path(quarter).should eql fiscal_quarter_path
    end
  end
end
