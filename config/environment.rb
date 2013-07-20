# Load the Rails application.
require File.expand_path('../application', __FILE__)

# Settings
RAW_SETTINGS = File.read(Rails.root + "config/config.yml")
SETTINGS = YAML.load(RAW_SETTINGS)[Rails.env]

# Initialize the Rails application.
Dobroserver::Application.initialize!
