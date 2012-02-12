# encoding: utf-8

class PortadasController < ApplicationController
  respond_to :html
  before_filter :update_portada, only: [:update, :create]

  public_actions :principal

  def principal
    respond_with pagina, template: "paginas/show"
  end

  def new
  end

  def update
    respond_with portada, location: new_portada_path
  end

  def create
    respond_with portada, location: new_portada_path
  end

private
  def portada
    @portada ||= Portada.portada
  end

  def pagina
    @pagina ||= PaginaDecorator.decorate Portada.first!.pagina 
  end

  def update_portada
    portada.update_attributes params[:portada]
  end

  def paginas
    @paginas ||= Pagina.publicadas
  end

  helper_method :portada, :pagina, :paginas
end
