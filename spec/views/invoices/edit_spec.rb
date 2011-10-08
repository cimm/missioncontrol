require "spec_helper"

describe "invoices/edit" do
  let(:invoice) { mock_model(Invoice) }
  let(:form)    { mock("Form") }

  before :each do
    stub_template("invoices/_form" => "")
    assign :invoice, invoice
  end

  it "has a title" do
    render
    rendered.should have_content("Edit invoice")
  end

  it "has an edit form" do
    render
    rendered.should have_form(invoice_path(invoice), "post")
  end

  it "renders the form partial" do
    render
    view.should render_template(:partial => "_form", :object => form)
  end

  it "has a submit button" do
    render
    rendered.should have_button("Update invoice")
  end

  it "has a cancel link" do
    render
    rendered.should have_link("cancel")
  end
end
