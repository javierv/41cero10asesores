# encoding: utf-8

class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :conservar_parametros, :only => [:index]
  before_filter :authenticate_usuario!, :if => :requiere_usuario?

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
      self.params = session[session_key] if session[session_key]
    else
      session[session_key] = params
    end
  end

  def estan_accediendo_al_indice_principal?
    params.reject{|key, value| [:controller, :action].include?(key.to_sym)}.empty?
  end

  def session_key(action = nil)
    @session_key ||= :"#{params[:controller]}.#{action || params[:action]}"
  end
end
