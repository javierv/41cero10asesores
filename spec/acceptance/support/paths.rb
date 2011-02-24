module NavigationHelpers
  def homepage
    "/"
  end

  def login_page
    new_usuario_session_path
  end

  def admin_page
    paginas_path
  end

  def search_page
    search_paginas_path
  end
end

RSpec.configuration.include NavigationHelpers, :type => :acceptance
