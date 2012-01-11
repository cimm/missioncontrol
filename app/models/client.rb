require "open-uri"

class Client < ActiveRecord::Base
  LANGUAGE_PAIRS          = { "English" => "en", "Dutch" => "nl", "French" => "fr" }
  SPECIAL_CHARS_PATTERN   = /[^0-9A-Za-z]/
  ANY_NON_DIGIT_PATTERN   = /\D+/
  ANY_DIGIT_PATTERN       = /\d+/
  VAT_VALIDATION_URL_BASE = "http://isvat.appspot.com"
  PATH_SEPARATOR          = "/"

  validates :nickname, :presence => true

  def remove_special_chars(string)
    string.gsub(SPECIAL_CHARS_PATTERN, "")
  end

  def cleaned_vat_number
    remove_special_chars(vat_number)
  end

  def vat_number_country_code
    cleaned_vat_number.slice(ANY_NON_DIGIT_PATTERN)
  end

  def vat_number_without_country_code
    cleaned_vat_number.slice(ANY_DIGIT_PATTERN)
  end

  def vat_validation_url
    [VAT_VALIDATION_URL_BASE, vat_number_country_code, vat_number_without_country_code].join(PATH_SEPARATOR)
  end

  def has_valid_vat_number?
    return false if !vat_number
    response = open(vat_validation_url).read
    response == "true" ? true : false
  end
end
