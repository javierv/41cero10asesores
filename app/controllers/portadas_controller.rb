# encoding: utf-8

class PortadasController < ApplicationController
  respond_to :html
  public_actions :principal

  expose(:portada) { Portada.portada }
  expose(:pagina) { PaginaDecorator.decorate Portada.first!.pagina  }
  expose(:paginas) { Pagina.publicadas }

  before_filter :update_portada, only: [:update, :create]

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
  def update_portada
    portada.update_attributes params[:portada]
  end
end
