# encoding: utf-8

class NavegacionCell < ApplicationCell
  expose(:paginas) { Navegacion.paginas }
  cache :display, :paginas

  def display
    render
  end
end
