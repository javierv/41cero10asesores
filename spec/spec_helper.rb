require 'rubygems'
require 'spork'

Spork.prefork do
  # Loading more in this block will cause your tests to run faster. However, 
  # if you change any configuration or code from libraries loaded here, you'll
  # need to restart spork for it take effect.
  
  require 'simplecov'
  SimpleCov.start 'rails'
  # This file is copied to spec/ when you run 'rails generate rspec:install'
  ENV["RAILS_ENV"] ||= 'test'
  require File.expand_path("../../config/environment", __FILE__)
  require 'rspec/rails'
  require 'capybara/rspec/matchers'

  # Requires supporting ruby files with custom matchers and macros, etc,
  # in spec/support/ and its subdirectories.
  Dir[Rails.root.join("spec/support/**/*.rb")].each {|f| require f}

  RSpec.configure do |config|
    # Don't stub views
    config.render_views
    # == Mock Framework
    #
    # If you prefer to use mocha, flexmock or RR, uncomment the appropriate line:
    #
    config.mock_with :mocha
    # config.mock_with :flexmock
    # config.mock_with :rr
    #config.mock_with :rspec

    # Remove this line if you're not using ActiveRecord or ActiveRecord fixtures
    config.fixture_path = "#{::Rails.root}/spec/fixtures"

    # If you're not using ActiveRecord, or you'd prefer not to run each of your
    # examples within a transaction, remove the following line or assign false
    # instead of true.
    config.use_transactional_fixtures = true

    config.include Devise::TestHelpers, type: :controller
    config.include Capybara::RSpecMatchers, type: :helper
  end
end

Spork.each_run do
  Calesur::Application.reload_routes!
  # This code will be run each time you run your specs.
  def authenticate_usuario
    @usuario = Factory :usuario
    sign_in @usuario
  end

  def falla_validacion(modelo)
    errors = ActiveModel::Errors.new(modelo.new)
    errors.add_on_blank(:id)
    modelo.any_instance.stubs(:errors).returns(errors)
    modelo.any_instance.stubs(:valid?).returns(false)
  end

  def valida_siempre(modelo)
    modelo.any_instance.stubs(:errors).returns({})
    modelo.any_instance.stubs(:valid?).returns(true)
  end
end