# encoding: utf-8

class ApplicationCell < Cell::Rails
  class << self
    # Hack: se añade el método porque 
    # decent_exposure asume que existe
    # (ya que está pensado para ActionController)
    alias_method :hide_action, :private
  end
  include DecentExposure::DefaultExposure

  helper :navegacion
  include Devise::Controllers::Helpers
  helper_method :usuario_signed_in?
  helper_method :current_usuario

  def expose(method, &block)
    self.class.expose(method) { block.call }
  end
end
