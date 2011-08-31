require "spec_helper"

describe "units/index" do
  let(:unit)        { mock_model(Unit) }
  let(:units)       { [unit] }
  let(:executed_at) { Date.today }
  let(:client)      { mock_model(Client)}
  let(:nickname)    { "Acme" }
  let(:clients)     { [client] }
  let(:total_units) { mock("Total number of units") }

  before :each do
    unit.stub(:executed_at => executed_at, :client_id => nil, :client_nickname => nickname)
    client.stub(:nickname => nickname)
    assign :unit,        unit
    assign :units,       units
    assign :client,      client
    assign :clients,     clients
    assign :total_units, total_units
  end

  it "has a title" do
    render
    rendered.should have_content("Units")
  end

  it "shows the date the units were executed" do
    render
    rendered.should have_tag("td", :with => {:class => "executed_at"}, :text => /#{executed_at}/i)
  end

  it "shows the client nicknames for the units" do
    render
    rendered.should have_tag("td", :with => {:class => "nickname"}, :text => /#{nickname}/i)
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

  it "has a client field for the new unit" do
    render
    rendered.should have_tag("select", :with => {:id => "unit_client_id"}) do
      with_tag "option", :with => {:value => client.id}, :text => /#{nickname}/i
    end
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
  let(:unit)     { mock_model(Unit) }
  let(:client)   { mock_model(Client) }
  let(:clients)  { [client] }
  let(:nickname) { "Acme" }

  before :each do
    unit.stub(:executed_at => nil, :client_id => client)
    client.stub(:nickname => nickname)
    assign :unit, unit
    assign :clients, clients
  end

  it "should have a title" do
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

  it "has a label for the client field" do
    render
    rendered.should have_content("Client")
  end

  it "has a client field" do
    render
    rendered.should have_tag("select", :with => {:id => "unit_client_id"}) do
      with_tag "option", :with => {:value => client.id}, :text => /#{nickname}/i
    end
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
