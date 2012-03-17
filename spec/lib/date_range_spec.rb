require "spec_helper"
require "date_range"

describe DateRange do
  let(:range)      { mock("Range") }
  let(:date_range) { DateRange.new(range) }

  describe :start_date do
    let(:start_date_part) { mock("Start date part") }
    let(:splitted_range)  { [start_date_part, mock("End date part")] }
    let(:start_date)      { mock("Start date") }

    before :each do
      date_range.stub(:split_in_start_and_end_date => splitted_range)
      Date.stub(:strptime => start_date)
    end

    it "splits the range in a start and end date" do
      date_range.should_receive(:split_in_start_and_end_date)
      date_range.start_date
    end

    it "gets the start date part from the splitted range" do
      splitted_range.should_receive(:first)
      date_range.start_date
    end

    it "converts the splitted start date part to a date" do
      Date.should_receive(:strptime).with(start_date_part, DATE_FORMAT)
      date_range.start_date
    end

    it "returns the start date" do
      date_range.start_date.should eql start_date
    end
  end

  describe :end_date do
    let(:range)          { mock("Range") }
    let(:end_date_part)  { mock("End date part") }
    let(:splitted_range) { [mock("Start date part"), end_date_part] }
    let(:end_date)       { mock("End date") }

    before :each do
      date_range.stub(:split_in_start_and_end_date => splitted_range)
      Date.stub(:strptime => end_date)
    end

    it "splits the range in a start and end date" do
      date_range.should_receive(:split_in_start_and_end_date)
      date_range.end_date
    end

    it "gets the end date part from the splitted range" do
      splitted_range.should_receive(:last)
      date_range.end_date
    end

    it "converts the splitted end date part to a date" do
      Date.should_receive(:strptime).with(end_date_part, DATE_FORMAT)
      date_range.end_date
    end

    it "returns the end date" do
      date_range.end_date.should eql end_date
    end
  end

  describe :split_in_start_and_end_date do
    let(:start_date_part)    { "2012-01-01" }
    let(:end_date_part)      { "2012-04-01" }
    let(:range)              { "#{start_date_part}to#{end_date_part}" }
    let(:start_and_end_date) { [start_date_part, end_date_part] }

    it "returns the start date as the first part and end date as the last part" do
      date_range.split_in_start_and_end_date.should eql start_and_end_date
    end
  end
end
