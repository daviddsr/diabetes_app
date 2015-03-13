source 'https://rubygems.org'

gem 'rails', '4.1.7'

gem 'gon'
gem 'sass-rails', '~> 4.0.3'
gem 'uglifier', '>= 1.3.0'

gem 'jquery-rails'
gem 'turbolinks'
gem 'jbuilder', '~> 2.0'
gem "mongoid", "~> 4.0.0"
gem 'devise'

group :development, :test do
  gem 'rspec-rails', '~> 3.0'
  gem 'cucumber-rails', :require => false
  gem 'factory_girl_rails'
  gem 'database_cleaner'
  gem 'pry'
  gem 'validates_timeliness', '~> 3.0'
  gem 'timecop', '0.7.1'
  gem 'awesome_print'
end

group :development do
  gem 'guard-rails'
end

group :test do
  gem 'shoulda-matchers', require: false
  gem "capybara-webkit"
end

group :production do
	gem 'rails_12factor'
end
