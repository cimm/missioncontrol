require "spec_helper"

describe "units/index" do
  let(:unit)                  { mock_model(Unit) }
  let(:units)                 { [unit] }
  let(:project)               { mock_model(Project) }
  let(:name)                  { "Project Stradivarius" }
  let(:hours_spent)           { 8 }
  let(:formatted_hours_spent) { "8 hours" }
  let(:executed_at)           { Date.today }
  let(:total_units)           { mock("Total number of units") }

  before :each do
    unit.stub(:executed_at => executed_at, :project_name => name, :hours_spent => hours_spent)
    project.stub(:name => name)
    view.stub(:formatted_hours => formatted_hours_spent)
    assign :units,       units
    assign :total_units, total_units
  end

  it "has a title" do
    render
    rendered.should have_content("Units")
  end

  it "has a link to create a new unit" do
    render
    rendered.should have_link("New")
  end

  it "shows the date the units were executed" do
    render
    rendered.should have_tag("td", :with => {:class => "executed_at"}, :text => /#{executed_at}/i)
  end

  it "shows the project names for the units" do
    render
    rendered.should have_tag("td", :with => {:class => "name"}, :text => /#{name}/i)
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
    rendered.should have_tag("td", :with => {:class => "hours_spent"}, :text => /#{formatted_hours_spent}/i)
  end

  it "shows an edit link for the units" do
    render
    rendered.should have_selector("a#edit_unit_#{unit.id}")
  end

  it "shows the total units" do
    render
    rendered.should have_content("Total: #{total_units} units")
  end
end

describe "units/new" do
  let(:unit)     { mock_model(Unit) }
  let(:project)  { mock_model(Project) }
  let(:projects) { [project] }
  let(:name)     { "Project Stradivarius" }

  before :each do
    unit.stub(:executed_at => nil, :project_id => nil, :hours_spent => nil)
    project.stub(:name => name)
    assign :unit,     unit
    assign :project,  project
    assign :projects, projects
  end

  it "has a title" do
    render
    rendered.should have_content("New unit")
  end

  it "has a label for the executed date fields" do
    render
    rendered.should have_content("Executed at")
  end

  it "has a executed date fields" do
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

  it "has a label for the project field" do
    render
    rendered.should have_content("Project")
  end

  it "has a project field" do
    render
    rendered.should have_tag("select", :with => {:id => "unit_project_id"}) do
      with_tag "option", :with => {:value => project.id}, :text => /#{name}/i
    end
  end

  it "has a label for the hours spent field" do
    render
    rendered.should have_content("Hours spent")
  end

  it "has an hours spent field" do
    render
    rendered.should have_selector("#unit_hours_spent")
  end

  it "has a submit button" do
    render
    rendered.should have_button("Add unit")
  end

  it "has a cancel link" do
    render
    rendered.should have_link("cancel")
  end
end

describe "units/edit" do
  let(:unit)     { mock_model(Unit) }
  let(:project)  { mock_model(Project) }
  let(:projects) { [project] }
  let(:name)     { "Project Stradivarius" }

  before :each do
    unit.stub(:executed_at => nil, :project_id => nil, :hours_spent => nil)
    project.stub(:name => name)
    assign :unit, unit
    assign :projects, projects
  end

  it "has a title" do
    render
    rendered.should have_content("Edit unit")
  end

  it "has a label for the executed date fields" do
    render
    rendered.should have_content("Executed at")
  end

  it "has executed date fields" do
    render
    rendered.should have_selector("#unit_executed_at_1i")
    rendered.should have_selector("#unit_executed_at_2i")
    rendered.should have_selector("#unit_executed_at_3i")
  end

  it "has a label for the project field" do
    render
    rendered.should have_content("Project")
  end

  it "has a project field" do
    render
    rendered.should have_tag("select", :with => {:id => "unit_project_id"}) do
      with_tag "option", :with => {:value => project.id}, :text => /#{name}/i
    end
  end

  it "has a label for the hours spent field" do
    render
    rendered.should have_content("Hours spent")
  end

  it "has an hours spent field" do
    render
    rendered.should have_selector("#unit_hours_spent")
  end

  it "has a submit button" do
    render
    rendered.should have_button("Update unit")
  end

  it "has a cancel link" do
    render
    rendered.should have_link("cancel")
  end
end
