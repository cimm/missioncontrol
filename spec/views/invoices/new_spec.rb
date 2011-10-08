require "spec_helper"

describe "invoices/new" do
  let(:invoice) { mock_model(Invoice) }
  let(:form)    { mock("Form") }

  before :each do
    stub_template("invoices/_form" => "")
    assign :invoice, invoice
  end

  it "has a title" do
    render
    rendered.should have_content("New invoice")
  end

  it "has a new form" do
    render
    rendered.should have_form(invoice_path(invoice), "post")
  end

  it "renders the form partial" do
    render
    view.should render_template(:partial => "_form", :object => form)
  end

  it "has a submit button" do
    render
    rendered.should have_button("Add invoice")
  end

  it "has a cancel link" do
    render
    rendered.should have_link("cancel")
  end
end
