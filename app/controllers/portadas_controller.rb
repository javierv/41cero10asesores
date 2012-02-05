# encoding: utf-8

class PortadasController < ApplicationController
  respond_to :html

  public_actions :show

  def show
    @pagina = Portada.pagina
    respond_with @pagina, template: "paginas/show"
  end
end
