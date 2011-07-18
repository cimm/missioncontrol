require File.expand_path('../boot', __FILE__)

require 'rails/all'

Bundler.require(:default, Rails.env) if defined?(Bundler)

module Invoicr
  class Application < Rails::Application
    config.time_zone = 'Brussels'
    config.encoding = "utf-8"
    config.filter_parameters += [:password]
    config.assets.enabled = true
  end
end
