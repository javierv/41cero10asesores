# encoding: utf-8

class AdminCell < Cell::Rails
  helper :navegacion
  include Devise::Controllers::Helpers
  helper_method :usuario_signed_in?
  helper_method :current_usuario

  def menu
    if usuario_signed_in?
      render
    else
      render text: ""
    end
  end
end
