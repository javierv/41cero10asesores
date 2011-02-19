module NavigationHelpers
  def homepage
    "/"
  end

  def login_page
    new_usuario_session_path
  end
end

RSpec.configuration.include NavigationHelpers, :type => :acceptance
