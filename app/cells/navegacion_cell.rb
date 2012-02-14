# encoding: utf-8

class NavegacionCell < ApplicationCell
  def display
    render
  end

private
  def paginas
    @paginas ||= Navegacion.paginas
  end

  helper_method :paginas
end
