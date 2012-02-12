# encoding: utf-8

class ApplicationController < ActionController::Base
  responders :flash
  protect_from_forgery
  before_filter :conservar_parametros, only: [:index]
  before_filter :authenticate_usuario!, if: :requiere_usuario?
  before_filter :paginas_navegacion

private
  def public_actions
    []
  end

  def self.public_actions(*args)
    define_method :public_actions do
      args
    end
  end

  def paginas_navegacion
    @paginas_navegacion = Navegacion.paginas
  end

  def requiere_usuario?
    !public_actions.include?(action_name.to_sym)
  end

  def after_sign_in_path_for(resource)
    paginas_path
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

    define_method :decorator_class do
      "#{resource_name}Decorator".camelize.constantize
    end

    define_method :"new_#{resource_name}" do
      decorator_class.decorate(resource_class.new(params[resource_name]))
    end

    define_method :"find_#{resource_name}" do
      decorator_class.find(params[:id])
    end

    define_method :"find_or_new_#{resource_name}" do
      if params[:id]
        send :"find_#{resource_name}"
      else
        send :"new_#{resource_name}"
      end
    end

    define_method :resource do
      send :"#{resource_name}"
    end

    define_method :"paginate_#{resource_name.to_s.pluralize}" do
      search, records = resource_class.search_paginate params
      instance_variable_set "@search", search
      instance_variable_set "@#{resource_name.to_s.pluralize}", decorator_class.decorate(records)
    end

    define_method :"next_resource" do
      resource_class.next(session_params(:index) || {})
    end

    define_method :"destroy_#{resource_name}" do
      if resource.destroy
        @deshacer = resource.deshacer_borrado_path
        if next_resource && request.xhr?
          @siguiente = decorator_class.decorate next_resource
        end
      end
    end

    helper_method :resource
  end
end
