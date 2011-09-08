require "spec_helper"

describe TimeHelper do
  describe "fromatted_hours" do
    let(:hours_to_format) { mock("Hours") }
    let(:hours_as_time)   { mock("Hours converted to a Time object") }
    let(:time_now)        { mock("Time right now") }
    let(:future_time)     { mock("Time now + hours_to_format") }
    let(:formatted_hours) { mock("Formatted hours") }

    before :each do
      hours_to_format.stub(:hours => hours_as_time)
      Time.stub(:now => time_now)
      time_now.stub(:+ => future_time)
      helper.stub(:distance_of_time_in_words => formatted_hours)
    end

    it "converts the hours to format to a Time object" do
      hours_to_format.should_receive(:hours).and_return(hours_as_time)
      helper.formatted_hours(hours_to_format)
    end

    it "adds the converted hours to the current time" do
      Time.now.should_receive(:+).with(hours_as_time).and_return(future_time)
      helper.formatted_hours(hours_to_format)
    end

    it "converts the hours to format in a nicer string representation" do
      helper.should_receive(:distance_of_time_in_words).with(time_now, future_time).and_return(formatted_hours)
      helper.formatted_hours(hours_to_format)
    end

    it "returns the formatted hours" do
      helper.formatted_hours(hours_to_format).should eql formatted_hours
    end
  end
end
