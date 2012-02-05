# encoding: utf-8

class PortadasController < ApplicationController
  respond_to :html
  before_filter :find_portada

  public_actions :show

  def show
    @pagina = @portada.pagina
    respond_with @pagina
  end

  def new
    @paginas = Pagina.publicadas
  end

  def update
    @portada.update_attributes params[:portada]
    respond_with @portada, location: new_portada_path
  end

private
  def find_portada
    @portada = Portada.portada
  end
end
