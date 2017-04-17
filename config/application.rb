require_relative 'boot'
require 'rails/all'

Bundler.require(*Rails.groups)

module Twistedchat
  class Application < Rails::Application
  end
end
