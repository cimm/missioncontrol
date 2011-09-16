require "spec_helper"

describe "units/index" do
  let(:unit)                  { mock_model(Unit) }
  let(:units)                 { [unit] }
  let(:project)               { mock_model(Project) }
  let(:name)                  { "Project Stradivarius" }
  let(:hours_spent)           { 8 }
  let(:formatted_hours_spent) { "8 hours" }
  let(:executed_at)           { Date.today }

  before :each do
    unit.stub(:executed_at => executed_at, :project_name => name, :hours_spent => hours_spent)
    project.stub(:name => name)
    view.stub(:formatted_hours => formatted_hours_spent)
    assign :units, units
  end

  it "has a title" do
    render
    rendered.should have_content("Units")
  end

  it "has a link to create a new unit" do
    render
    rendered.should have_link("New")
  end

  it "gets the date the units were executed" do
    units.each do |u|
      u.should_receive(:executed_at).and_return(executed_at)
    end
    render
  end

  it "shows the date the units were executed" do
    render
    rendered.should have_tag(".executed_at", :text => executed_at.to_s)
  end

  it "gets the project names for the units" do
    units.each do |u|
      u.should_receive(:project_name).and_return(name)
    end
    render
  end

  it "shows the project names for the units" do
    render
    rendered.should have_tag(".name", :text => name)
  end

  it "gets the hours spent for the units" do
    units.each do |u|
      u.should_receive(:hours_spent).and_return(hours_spent)
    end
    render
  end

  it "formats the hours spent for the units" do
    units.each do |u|
      view.should_receive(:formatted_hours).and_return(formatted_hours_spent)
    end
    render
  end

  it "shows the formatted hours spent for the units" do
    render
    rendered.should have_tag(".hours_spent", :text => formatted_hours_spent)
  end

  it "shows an edit link for the units" do
    render
    rendered.should have_selector("a#edit_unit_#{unit.id}")
  end
end
