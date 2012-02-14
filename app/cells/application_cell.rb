class ApplicationCell < Cell::Rails
  helper :navegacion

  include Devise::Controllers::Helpers
  helper_method :usuario_signed_in?
  helper_method :current_usuario
end
