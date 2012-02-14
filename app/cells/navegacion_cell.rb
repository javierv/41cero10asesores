# encoding: utf-8

class NavegacionCell < Cell::Rails
  helper :navegacion

  def display
    render
  end

private
  def paginas
    @paginas ||= Navegacion.paginas
  end

  helper_method :paginas
end
