source 'https://rubygems.org'

ruby '2.2.3'

gem 'rails', '4.2.4'
gem 'pg'    # TODO: Specify version
gem 'turbolinks', '~> 2.5'
# Use puma as the app server
gem 'puma', '~> 2.13.4'
gem 'devise', '~> 3.5.2'
gem 'activeadmin', github: 'thoughtworks/activeadmin', branch: 'master'

gem 'sass-rails', '~> 5.0'
gem 'uglifier', '~> 2.7.2'
gem 'coffee-rails', '~> 4.1.0'
gem 'jquery-rails', '~> 4.0.3'

gem 'compass-rails', '~> 2.0.5'
gem 'foundation-rails', '~> 5.5.2.1'
gem 'selectize-rails', '~> 0.12.1'
gem 'lograge', '~> 0.3.4'

group :development do
  gem 'capistrano-rails', '~> 1.1.2'
  gem 'capistrano-bundler', '~> 1.1.2'
  gem 'capistrano-rvm', '~> 0.1.2'
  gem 'capistrano-faster-assets', '~> 1.0'
  gem 'sepastian-capistrano3-unicorn', '~> 0.5.1', require: false
  gem 'airbrussh', '~> 0.2.1', require: false

  gem 'stackprof', '~> 0.2.7'
  gem 'derailed_benchmarks', '~> 1.0.1'
  gem 'brakeman', '~> 3.1.0', require: false
  gem 'flamegraph', '~> 0.1.0'
  gem 'rack-mini-profiler', '~> 0.9.7'
  gem 'binding_of_caller', '~> 0.7.2'
  gem 'rubocop', '~> 0.34', require: false
  gem 'lol_dba', '~> 2.0.0'
  gem 'jshint', '~> 1.4.0'
  gem 'active_sanity', '~> 0.3.0'

  gem 'letter_opener', '~> 1.4.1'
end

group :development, :test do
  gem 'spring', '~> 1.3.6'
  gem 'quiet_assets', '~> 1.1.0'
  gem 'byebug', '~> 6.0.2'
  gem 'better_errors', '~> 2.1.1'
  gem 'pry-rails', '~> 0.3.2'
  gem 'did_you_mean', '~> 0.10.0'
  gem 'annotate', '~> 2.6.5'
  gem 'rspec-rails', '~> 3.3.3'
  # gem 'rspec-instafail', '~> 0.2.5'
  gem 'bullet', '~> 4.14.4'
  gem 'metric_fu', '~> 4.12.0'
  gem 'web-console', '~> 2.2.1'
  gem 'rails_instrument', '~> 0.0.4'
  gem 'faker', '~> 1.5.0'

  # Use debugger
  # gem 'debugger'
end

group :test do
  # gem 'capybara'
  gem 'database_cleaner', '~> 1.5.0'
  gem 'factory_girl_rails', '~> 4.5'
  gem 'shoulda', '~> 3.5.0'
  gem 'simplecov', '~> 0.10.0', require: false
  # gem 'selenium-webdriver'
end

group :production do
  # Turn on caching using rack-cache
  gem 'rack-cache', '~> 1.2', require: 'rack/cache'
end
