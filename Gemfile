ruby '2.3.3'
source 'https://rubygems.org'
gem 'rails', '4.2.6'


# -----------------------------------------
# Javascript Resources
# -----------------------------------------
gem 'coffee-rails', '4.1.1'
gem 'jquery-rails', '4.1.0'
gem 'turbolinks'  , '2.5.3'


# -----------------------------------------
# Formating Utilities
# -----------------------------------------
gem 'uglifier', '2.7.2'
gem 'jbuilder', '2.4.1'


# -----------------------------------------
# Authentication and Permissions
# -----------------------------------------
gem 'devise', :git => 'https://github.com/plataformatec/devise.git'
gem 'activeadmin', github: 'activeadmin'
gem 'figaro'
gem 'cancancan', '~> 1.9'


# -----------------------------------------
# Layout and Rendering
# -----------------------------------------
gem 'sass-rails'
gem 'bootstrap-sass', '3.3.6'
gem 'will_paginate-bootstrap', '1.0.1'
gem 'breadcrumbs_on_rails', '~> 2.3.0'
gem 'bootstrap_form'
gem 'data-confirm-modal'
gem "twitter-bootstrap-rails"
gem 'momentjs-rails'
gem 'bootstrap-daterangepicker-rails'
gem 'best_in_place', '~> 3.0.1'
gem 'autonumeric-rails'
gem 'haml-rails', '~> 0.9.0'
gem 'simple_form'
gem 'client_side_validations'
gem 'client_side_validations-simple_form'



#------------------------------------------
# For Charts
#------------------------------------------
gem 'fusioncharts-rails'

#------------------------------------------
# For Featuring
#------------------------------------------
gem 'country_select'
gem 'mailgun_rails'
gem 'countries'
gem 'currencies'
gem 'friendly_id', '~> 5.2'
gem 'acts-as-taggable-on', '~> 4.0'


#------------------------------------------
# For Import And Export
#------------------------------------------
gem 'wicked_pdf'
gem 'wkhtmltopdf-binary'

#------------------------------------------
# For Searching
#------------------------------------------
gem 'ransack'
gem 'has_scope'

#------------------------------------------
# For Server
#------------------------------------------
# gem 'puma'

#------------------------------------------
# For Error Notifications
#------------------------------------------
gem 'exception_notification', '~> 4.2', '>= 4.2.1'

#------------------------------------------
# For Multimedia Uploading
#------------------------------------------
gem 'carrierwave'
gem "mini_magick"
gem 'fog'
gem 'roo'
gem 'filepicker-rails', '~> 2.1'
group :doc do
  gem 'sdoc', require: false
end

group :development, :test do
  gem 'spring', '1.6.3'
  gem 'byebug', '8.2.2'
  gem 'rspec-rails', '3.1.0'
  gem 'factory_girl_rails', '4.6.0'
  gem 'faker', '1.6.3'
  gem 'database_cleaner', '1.5.1'

  gem 'capybara', '2.6.2'
end

group :development do

  gem 'better_errors', '2.1.1'
  gem 'binding_of_caller', '0.7.2'
  gem 'web-console', '3.1.1'
  gem 'guard-rails', '0.7.2', require: false
  # gem 'rubocop', '0.37.2', require: false
  # gem 'guard-rubocop', '1.2.0'
  gem 'guard-rspec', '4.6.4', require: false
  gem 'annotate'
  gem 'sqlite3'
  gem 'letter_opener', '1.4.1'
  gem 'capistrano', '~> 3.6'
  gem 'capistrano-rails', '~> 1.2'
  gem 'capistrano-passenger', '~> 0.2.0'
  gem 'capistrano-rvm'
end

group :production do
  gem 'rails_12factor'
  gem 'pg'
end
