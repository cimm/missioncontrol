require "spec_helper"

describe "units/index" do
  let(:unit)        { mock_model(Unit) }
  let(:total_units) { mock("Total number of units") }

  before :each do
    assign :unit,        unit
    assign :total_units, total_units
  end

  it "has a title" do
    render
    rendered.should have_content("Units")
  end

  it "has a submit button to add a unit" do
    render
    rendered.should have_button("Add unit")
  end

  it "shows the total units" do
    render
    rendered.should have_content("Total: #{total_units} units")
  end
end
