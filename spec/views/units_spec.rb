require "spec_helper"

describe "units/index" do
  let(:unit)        { mock_model(Unit) }
  let(:units)       { [unit] }
  let(:total_units) { mock("Total number of units") }

  before :each do
    unit.stub(:executed_at)
    assign :unit,        unit
    assign :units,       units
    assign :total_units, total_units
  end

  it "has a title" do
    render
    rendered.should have_content("Units")
  end

  it "shows the date the units were executed" do
    render
    units.each do |u|
      rendered.should have_content(u.executed_at)
    end
  end

  it "has a executed date fields for the new unit" do
    render
    rendered.should have_selector('#unit_executed_at_1i')
    rendered.should have_selector('#unit_executed_at_2i')
    rendered.should have_selector('#unit_executed_at_3i')
  end

  it "shows the current date in the executed date fields" do
    today = Date.today
    render
    rendered.should have_xpath("//select[@id='unit_executed_at_1i']/option[@selected='selected' and @value='#{today.year}']")
    rendered.should have_xpath("//select[@id='unit_executed_at_2i']/option[@selected='selected' and @value='#{today.month}']")
    rendered.should have_xpath("//select[@id='unit_executed_at_3i']/option[@selected='selected' and @value='#{today.day}']")
  end

  it "has a submit button to add the new unit" do
    render
    rendered.should have_button("Add unit")
  end

  it "shows the total units" do
    render
    rendered.should have_content("Total: #{total_units} units")
  end
end
