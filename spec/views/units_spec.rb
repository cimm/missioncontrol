require "spec_helper"

describe "units/index" do
  let(:unit)        { mock_model(Unit) }
  let(:units)       { [unit] }
  let(:executed_at) { Date.today }
  let(:total_units) { mock("Total number of units") }

  before :each do
    unit.stub(:executed_at => executed_at)
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
    rendered.should have_content(executed_at)
  end

  it "shows an edit link for the units" do
    render
    units.each do |u|
      rendered.should have_selector("a#edit_unit_#{u.id}")
    end
  end

  it "has a executed date fields for the new unit" do
    render
    rendered.should have_selector("#unit_executed_at_1i")
    rendered.should have_selector("#unit_executed_at_2i")
    rendered.should have_selector("#unit_executed_at_3i")
  end

  it "shows the current date in the executed date fields" do
    today = Date.today
    render
    rendered.should have_tag("select") do
      with_tag "option", :with => {:selected => "selected", :value => today.year}
      with_tag "option", :with => {:selected => "selected", :value => today.month}
      with_tag "option", :with => {:selected => "selected", :value => today.day}
    end
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

describe "units/edit" do
  let(:unit) { mock_model(Unit) }

  before :each do
    unit.stub(:executed_at)
    assign :unit, unit
  end

  it "should have a title" do
    render
    rendered.should have_content("Edit unit")
  end

  it "has an executed date fields for the unit" do
    render
    rendered.should have_selector("#unit_executed_at_1i")
    rendered.should have_selector("#unit_executed_at_2i")
    rendered.should have_selector("#unit_executed_at_3i")
  end

  it "has a submit button to update the unit" do
    render
    rendered.should have_button("Update unit")
  end
end
