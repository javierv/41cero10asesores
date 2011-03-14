# encoding: utf-8

class ApplicationController < ActionController::Base
  responders :flash
  protect_from_forgery
  before_filter :conservar_parametros, only: [:index]
  before_filter :authenticate_usuario!, if: :requiere_usuario?

private
  def public_actions
    []
  end

  def self.public_actions(*args)
    define_method :public_actions do
      args
    end
  end

  def requiere_usuario?
    !public_actions.include?(action_name.to_sym)
  end

  def conservar_parametros
    if estan_accediendo_al_indice_principal?
      self.params = session_params if session_params
    else
      self.session_params = params
    end
  end

  def estan_accediendo_al_indice_principal?
    params.reject{|key, value| [:controller, :action].include?(key.to_sym)}.empty?
  end

  def session_params(action = nil)
    session[session_key(action)]
  end

  def session_params=(params, action = nil)
    session[session_key(action)] = params
  end

  def session_key(action = nil)
    @session_key ||= :"#{params[:controller]}.#{action || params[:action]}"
  end

  def self.resource(resource_name)
    define_method :resource_class do
      resource_name.to_s.camelize.constantize
    end

    define_method :set_resource do |value|
      instance_variable_set "@#{resource_name}", value
    end

    define_method :"new_#{resource_name}" do
      set_resource resource_class.new(params[resource_name])
    end

    define_method :"find_#{resource_name}" do
      set_resource resource_class.find(params[:id])
    end

    define_method :"paginate_#{resource_name.to_s.pluralize}" do
      search, records = resource_class.search_paginate params
      instance_variable_set "@search", search
      instance_variable_set "@#{resource_name.to_s.pluralize}", records
    end

    define_method :"next_#{resource_name}" do
      resource_class.next(session_params(:index) || {})
    end
  end
end
