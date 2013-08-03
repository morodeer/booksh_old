# -*- encoding : utf-8 -*-
# Load the Rails application.
require File.expand_path('../application', __FILE__)

# Initialize the Rails application.
Booksh::Application.initialize!

Capybara.register_driver :selenium do |app|
	Capybara::Selenium::Driver.new(app, :browser => :chrome)
end
