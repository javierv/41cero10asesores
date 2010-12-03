class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :conservar_parametros, :only => [:index]

private
  def conservar_parametros
    session_key = :"#{params[:controller]}.#{params[:action]}"

    if estan_accediendo_al_indice_principal?
      self.params = session[session_key] if session[session_key]
    else
      session[session_key] = params
    end
  end

  def estan_accediendo_al_indice_principal?
    params.reject{|key, value| [:controller, :action].include?(key.to_sym)}.empty?
  end
end
