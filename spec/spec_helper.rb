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

  Devise.stretches = 1
  Rails.logger.level = 4

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

    config.include Devise::TestHelpers, type: :controller
    config.include Capybara::RSpecMatchers, type: :helper

    config.use_transactional_fixtures = true

    config.before(:each) do
      ActionMailer::Base.deliveries.clear
    end
  end
end

Spork.each_run do
  # This code will be run each time you run your specs.
  Calesur::Application.reload_routes!

  class ActiveRecord::Base
    mattr_accessor :shared_connection
    @@shared_connection = nil

    def self.connection
      @@shared_connection || retrieve_connection
    end
  end
  # Forces all threads to share the same connection. This works on
  # Capybara because it starts the web server in a thread.
  ActiveRecord::Base.shared_connection = ActiveRecord::Base.connection

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
    modelo.any_instance.stubs(:errors).returns(Hash.new {[]})
    modelo.any_instance.stubs(:valid?).returns(true)
  end

  def define_match(nombre, &block)
    RSpec::Matchers.define nombre do |expected|
      match { |actual| block[actual, expected] }
    end
  end

  # No he conseguido usar define_method para quitar duplicación.
  def crea_paginas_con_titulos(titulos)
    crea_con_titulos :pagina, titulos
  end
  
  def crea_cajas_con_titulos(titulos)
    crea_con_titulos :caja, titulos
  end

  def crea_con_titulos(modelo, titulos)
    titulos.map {|titulo| Factory modelo, titulo: titulo}
  end

  def crea_portada
    Factory :portada, pagina: Factory(:pagina)
  end
end
