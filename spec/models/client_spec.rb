require "spec_helper"

describe Client do
  let(:client) { FactoryGirl.build(:client) }

  it "has a creation date" do
    client.should respond_to :created_at
    client.should respond_to :created_at=
  end

  it "has an updated date" do
    client.should respond_to :updated_at
    client.should respond_to :updated_at=
  end

  it "has a nickname" do
    client.should respond_to :nickname
    client.should respond_to :nickname=
  end

  it "isn't valid without a nickname" do
    client.nickname = nil
    client.should_not be_valid
  end

  it "has a name" do
    client.should respond_to :name
    client.should respond_to :name=
  end

  it "has a postcode" do
    client.should respond_to :postcode
    client.should respond_to :postcode=
  end

  it "has a city" do
    client.should respond_to :city
    client.should respond_to :city=
  end

  it "has a country" do
    client.should respond_to :country
    client.should respond_to :country=
  end

  it "has a VAT number" do
    client.should respond_to :vat_number
    client.should respond_to :vat_number=
  end

  describe :remove_special_chars do
    let(:string)         { "a-b.c d123" }
    let(:cleaned_string) { "abcd123" }

    it "only keeps letters and numbers" do
      string.should_receive(:gsub).with(/[^0-9A-Za-z]/, "")
      client.remove_special_chars(string)
    end

    it "returns the cleaned string" do
      client.remove_special_chars(string).should eql cleaned_string
    end
  end

  describe :cleaned_vat_number do
    let(:vat_number)         { mock("VAT number") }
    let(:cleaned_vat_number) { mock("Cleaned VAT number") }
    before :each do
      client.stub(:vat_number => vat_number)
      client.stub(:remove_special_chars => cleaned_vat_number)
    end

    it "gets the client VAT number" do
      client.should_receive(:vat_number)
      client.cleaned_vat_number
    end

    it "removes all special characters from the VAT number" do
      client.should_receive(:remove_special_chars).with(vat_number)
      client.cleaned_vat_number
    end

    it "returns the cleaned VAT number" do
      client.cleaned_vat_number.should eql cleaned_vat_number
    end
  end

  describe :vat_number_country_code do
    let(:cleaned_vat_number) { mock("Cleaned VAT number") }
    let(:country_code)       { mock("Country code") }

    before :each do
      client.stub(:cleaned_vat_number => cleaned_vat_number)
      cleaned_vat_number.stub(:slice => country_code)
    end

    it "gets the cleaned VAT number" do
      client.should_receive(:cleaned_vat_number)
      client.vat_number_country_code
    end

    it "extracts the country code from the cleaned VAT number" do
      cleaned_vat_number.should_receive(:slice).with(/\D+/)
      client.vat_number_country_code
    end

    it "returns the country code" do
      client.vat_number_country_code.should eql country_code
    end
  end

  describe :vat_number_without_country_code do
    let(:cleaned_vat_number)              { mock("Cleaned VAT number") }
    let(:vat_number_without_country_code) { mock("Cleaned VAT number") }

    before :each do
      client.stub(:cleaned_vat_number => cleaned_vat_number)
      cleaned_vat_number.stub(:slice => vat_number_without_country_code)
    end

    it "gets the cleaned VAT number" do
      client.should_receive(:cleaned_vat_number)
      client.vat_number_without_country_code
    end

    it "extracts the VAT number without country code from the cleaned VAT number" do
      cleaned_vat_number.should_receive(:slice).with(/\d+/)
      client.vat_number_without_country_code
    end

    it "returns the VAT number without country code" do
      client.vat_number_without_country_code.should eql vat_number_without_country_code
    end
  end

  describe :vat_validation_url do
    let(:country_code)                    { mock("Country code") }
    let(:vat_number_without_country_code) { mock("VAT number without country code") }
    let(:vat_validation_url)              { "http://isvat.appspot.com/#{country_code}/#{vat_number_without_country_code}" }

    before :each do
      client.stub(:vat_number_country_code => country_code, :vat_number_without_country_code => vat_number_without_country_code)
    end

    it "gets the country code from the VAT number" do
      client.should_receive(:vat_number_country_code)
      client.vat_validation_url
    end

    it "gets the VAT number without country code from the VAT number" do
      client.should_receive(:vat_number_without_country_code)
      client.vat_validation_url
    end

    it "returns the VAT validation URL" do
      client.vat_validation_url.should eql vat_validation_url
    end
  end

  describe :has_valid_vat_number? do
    context "client has no VAT number" do
      before :each do
        client.stub(:vat_number => nil)
      end

      it "returns false" do
        client.should_not have_valid_vat_number
      end
    end

    context "client has a VAT number" do
      let(:vat_number)                { mock("VAT number") }
      let(:vat_validation_url)        { mock("VAT validation URL") }
      let(:vat_validation_url_handle) { mock("VAT validation URL handle") }

      before :each do
        client.stub(:vat_number => vat_number, :vat_validation_url => vat_validation_url, :open => vat_validation_url_handle)
        vat_validation_url_handle.stub(:read)
      end

      it "gets the VAT validation URL" do
        client.should_receive(:vat_validation_url)
        client.has_valid_vat_number?
      end

      it "opens the VAT validation URL" do
        client.should_receive(:open).with(vat_validation_url)
        client.has_valid_vat_number?
      end

      it "reads the contents form the VAT validation URL handle" do
        vat_validation_url_handle.should_receive(:read)
        client.has_valid_vat_number?
      end

      context "the VAT number is valid" do
        before :each do
          vat_validation_url_handle.stub(:read => "true")
        end

        it "returns true" do
          client.should have_valid_vat_number
        end
      end

      context "the VAT number is not valid" do
        before :each do
          vat_validation_url_handle.stub(:read => "false")
        end

        it "returns false" do
          client.should_not have_valid_vat_number
        end
      end
    end
  end
end
