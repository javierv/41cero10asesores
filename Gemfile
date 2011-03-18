source 'http://rubygems.org'

gem 'rails', '3.0.5'
gem 'mysql2'

group :development, :test do
  gem "rspec-rails"
  gem 'jasmine'
end

group :development do
  gem 'hirb'
  gem 'faker'
  gem "rails3-generators"
  gem "jquery-rails"
end

group :test do
  gem 'sqlite3-ruby', :require => 'sqlite3'
  gem "shoulda-matchers"
  gem "factory_girl_rails"
  gem "mocha"
  gem "capybara", :git => "https://github.com/jnicklas/capybara.git"
  gem 'spork', '>= 0.9.0RC'
  gem 'guard-spork'
  gem 'simplecov', :require => false
  gem "database_cleaner"
  gem "launchy"
  gem "libnotify"
end

group :production, :development do
  gem 'mysql2'
end

group :production do
  gem 'mongrel', '>= 1.2.0.pre2'
end

# Use unicorn as the web server
# gem 'unicorn'

gem "devise"
gem "kaminari"
gem 'rack-cache', :require => 'rack/cache'
gem 'dragonfly'
gem "haml"
gem "compass"
gem "acts-as-taggable-on"
gem "validation_reflection"
gem "RedCloth"
gem "validates_date_time"
gem "meta_where"
gem "meta_search"
gem "simple_form", ">= 1.3"
gem "tabletastic"
gem "display_name"
gem "xapian_db"
gem "inploy"
gem "barista"
gem 'vestal_versions', :git => 'git://github.com/javierv/vestal_versions'
gem "therubyracer"
gem "differ"
gem 'whenever', :require => false
gem "friendly_id"
gem "responders"
gem 'spectator-validates_email', :require => 'validates_email'
gem "i18n-inflector-rails"
