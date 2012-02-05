# encoding: utf-8

class PortadasController < ApplicationController
  respond_to :html
  before_filter :find_portada
  before_filter :update_portada, only: [:update, :create]

  public_actions :principal

  def principal
    @pagina = @portada.pagina
    respond_with @pagina
  end

  def new
    @paginas = Pagina.publicadas
  end

  def update
    respond_with @portada, location: new_portada_path
  end

  def create
    respond_with @portada, location: new_portada_path
  end

private
  def find_portada
    @portada = Portada.portada
  end

  def update_portada
    @portada.update_attributes params[:portada]
  end
end
