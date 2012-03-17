require "spec_helper"
require "fiscal_quarter"

describe FiscalQuarter do
  MONTH_FORMAT = "%m"

  describe :starts_at do
    context "when the first quarter is requested" do
      let(:quarter)        { 1 }
      let(:fiscal_quarter) { FiscalQuarter.new(quarter) }
      let(:starts_at)      { Date.strptime("2012-01-01", "%Y-%m-%d") }

      it "returns January, 1st" do
        fiscal_quarter.starts_at.should eql starts_at
      end
    end

    context "when the second quarter is requested" do
      let(:quarter)        { 2 }
      let(:fiscal_quarter) { FiscalQuarter.new(quarter) }
      let(:starts_at)      { Date.strptime("2012-04-01", "%Y-%m-%d") }

      it "returns April, 1st" do
        fiscal_quarter.starts_at.should eql starts_at
      end
    end

    context "when the third quarter is requested" do
      let(:quarter)        { 3 }
      let(:fiscal_quarter) { FiscalQuarter.new(quarter) }
      let(:starts_at)      { Date.strptime("2012-07-01", "%Y-%m-%d") }

      it "returns July, 1st" do
        fiscal_quarter.starts_at.should eql starts_at
      end
    end

    context "when the forth quarter is requested" do
      let(:quarter)        { 4 }
      let(:fiscal_quarter) { FiscalQuarter.new(quarter) }
      let(:starts_at)      { Date.strptime("2012-10-01", "%Y-%m-%d") }

      it "returns October, 1st" do
        fiscal_quarter.starts_at.should eql starts_at
      end
    end
  end

  describe :ends_at do
    context "when the first quarter is requested" do
      let(:quarter)        { 1 }
      let(:fiscal_quarter) { FiscalQuarter.new(quarter) }
      let(:ends_at)        { Date.strptime("2012-03-31", "%Y-%m-%d") }

      it "returns March, 31st" do
        fiscal_quarter.ends_at.should eql ends_at
      end
    end

    context "when the second quarter is requested" do
      let(:quarter)        { 2 }
      let(:fiscal_quarter) { FiscalQuarter.new(quarter) }
      let(:ends_at)        { Date.strptime("2012-06-30", "%Y-%m-%d") }

      it "returns June, 30th" do
        fiscal_quarter.ends_at.should eql ends_at
      end
    end

    context "when the third quarter is requested" do
      let(:quarter)        { 3 }
      let(:fiscal_quarter) { FiscalQuarter.new(quarter) }
      let(:ends_at)        { Date.strptime("2012-09-30", "%Y-%m-%d") }

      it "returns September, 30th" do
        fiscal_quarter.ends_at.should eql ends_at
      end
    end

    context "when the forth quarter is requested" do
      let(:quarter)        { 4 }
      let(:fiscal_quarter) { FiscalQuarter.new(quarter) }
      let(:ends_at)        { Date.strptime("2012-12-31", "%Y-%m-%d") }

      it "returns December, 31st" do
        fiscal_quarter.ends_at.should eql ends_at
      end
    end
  end
end
