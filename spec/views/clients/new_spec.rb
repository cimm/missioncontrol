require "spec_helper"

describe "clients/new" do
  let(:client) { mock_model(Client) }
  let(:form)   { mock("Form") }

  before :each do
    stub_template("clients/_form" => "")
    assign :client, client
  end

  it "has a title" do
    render
    rendered.should have_content("New client")
  end

  it "has a new form" do
    render
    rendered.should have_form(client_path(client), "post")
  end

  it "renders the form partial" do
    render
    view.should render_template(:partial => "_form", :object => form)
  end

  it "has a submit button" do
    render
    rendered.should have_button("Add client")
  end

  it "has a cancel link" do
    render
    rendered.should have_link("cancel")
  end
end
