require "spec_helper"

describe "expenses/edit" do
  let(:expense) { mock_model(Expense) }
  let(:form)    { mock("Form") }

  before :each do
    stub_template("expenses/_form" => "")
    assign :expense, expense
  end

  it "has a title" do
    render
    rendered.should have_content("Edit expense")
  end

  it "has an edit form" do
    render
    rendered.should have_form(expense_path(expense), "post")
  end

  it "renders the form partial" do
    render
    view.should render_template(:partial => "_form", :object => form)
  end

  it "has a submit button" do
    render
    rendered.should have_button("Update expense")
  end

  it "has a cancel link" do
    render
    rendered.should have_link("cancel")
  end
end
