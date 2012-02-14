# encoding: utf-8

class CabeceraCell < Cell::Rails
  include Devise::Controllers::Helpers
  helper_method :usuario_signed_in?
  helper_method :current_usuario

  def display
    render
  end

  def logo
    render
  end

  def access
    render
  end

  def lema
    render
  end
end
