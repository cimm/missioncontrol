require "spec_helper"

describe "clients/_form" do
  let(:client)         { mock_model(Client) }
  let(:partial_render) { render :partial => "clients/form", :object => @form }

  before :each do
    client.stub(:nickname => nil, :name => nil, :street => nil, :postcode => nil, :city => nil, :country => nil, :language => nil, :vat_number => nil)
    form_for(client) { |f| @form = f }
  end

  it "has a label for the nickname field" do
    partial_render
    rendered.should have_content("Nickname")
  end

  it "has a nickname text field for the client" do
    partial_render
    rendered.should have_selector("#client_nickname")
  end

  it "has a label for the name field" do
    partial_render
    rendered.should have_content("Name")
  end

  it "has a name text field for the client" do
    partial_render
    rendered.should have_selector("#client_name")
  end

  it "has a label for the street field" do
    partial_render
    rendered.should have_content("Street")
  end

  it "has a street text field for the client" do
    partial_render
    rendered.should have_selector("#client_street")
  end

  it "has a label for the postcode field" do
    partial_render
    rendered.should have_content("Postcode")
  end

  it "has a postcode text field for the client" do
    partial_render
    rendered.should have_selector("#client_postcode")
  end

  it "has a label for the city field" do
    partial_render
    rendered.should have_content("City")
  end

  it "has a city text field" do
    partial_render
    rendered.should have_selector("#client_city")
  end

  it "has a label for the country field" do
    partial_render
    rendered.should have_content("Country")
  end

  it "has a country text field for the client" do
    partial_render
    rendered.should have_selector("#client_country")
  end

  it "has a label for the language select" do
    partial_render
    rendered.should have_content("Language")
  end

  it "has a language select box for the client" do
    partial_render
    rendered.should have_selector("#client_language")
  end

  it "has a label for the VAT number field" do
    partial_render
    rendered.should have_content("VAT number")
  end

  it "has a VAT number text field" do
    partial_render
    rendered.should have_selector("#client_vat_number")
  end

  context "new record" do
    it "does not show the VAT number status" do
      partial_render
      rendered.should_not have_content("VALID")
      rendered.should_not have_content("NOT VALID")
    end
  end

  context "edit record with valid VAT number" do
    before :each do
      assign(:vat_number_valid, true)
    end

    it "indicates the VAT number is valid" do
      partial_render
      rendered.should have_content("VALID")
    end
  end

  context "edit record with an invalid VAT number" do
    before :each do
      assign(:vat_number_valid, false)
    end

    it "warns that the VAT number is invalid" do
      partial_render
      rendered.should have_content("NOT VALID")
    end
  end
end
