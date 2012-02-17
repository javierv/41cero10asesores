# encoding: utf-8

class NavegacionCell < ApplicationCell
  expose(:paginas) { Navegacion.paginas }

  def display
    render
  end
end
