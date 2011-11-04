require "spec_helper"

describe "units/_form" do
  let(:unit)           { mock_model(Unit) }
  let(:project)        { mock_model(Project) }
  let(:projects)       { [project] }
  let(:name)           { mock("Project name") }
  let(:today)          { Date.today }
  let(:partial_render) { render :partial => "units/form", :object => @form }

  before :each do
    unit.stub(:executed_at => nil, :project_id => nil, :hours_spent => nil)
    project.stub(:name => name)
    assign :projects, projects
    form_for(unit) { |f| @form = f }
  end

  it "has a label for the executed date fields" do
    partial_render
    rendered.should have_content("Executed at")
  end

  it "has executed date fields" do
    partial_render
    rendered.should have_selector("#unit_executed_at_1i")
    rendered.should have_selector("#unit_executed_at_2i")
    rendered.should have_selector("#unit_executed_at_3i")
  end

  context "new" do
    it "shows the current date in the executed date fields" do
      partial_render
      rendered.should have_tag("select") do
        with_tag "option", :with => {:selected => "selected", :value => today.year}
        with_tag "option", :with => {:selected => "selected", :value => today.month}
        with_tag "option", :with => {:selected => "selected", :value => today.day}
      end
    end
  end

  context "edit" do
    before :each do
      unit.stub(:executed_at => today - 1.week)
    end

    it "does not show the current date in the executed date fields" do
      last_week = today - 1.week
      partial_render
      rendered.should have_tag("select") do
        with_tag "option", :with => {:selected => "selected", :value => last_week.year}
        with_tag "option", :with => {:selected => "selected", :value => last_week.month}
        with_tag "option", :with => {:selected => "selected", :value => last_week.day}
      end
    end
  end

  it "has a label for the project field" do
    partial_render
    rendered.should have_content("Project")
  end

  it "has a project field" do
    partial_render
    rendered.should have_tag("select", :with => {:id => "unit_project_id"}) do
      with_tag "option", :with => {:value => project.id}, :text => name
    end
  end

  it "has a label for the hours spent field" do
    partial_render
    rendered.should have_content("Hours spent")
  end

  it "has an hours spent field" do
    partial_render
    rendered.should have_selector("#unit_hours_spent")
  end
end
