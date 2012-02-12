# encoding: utf-8

class CajasController < ApplicationController
  respond_to :js, only: [:index, :destroy]
  respond_to :html

  resource :caja

  before_filter :paginate_cajas, only: :index
  before_filter :destroy_caja, only: :destroy

  def index
    respond_with @cajas
  end

  def new
    respond_with caja
  end

  def edit
    respond_with caja
  end

  def create
    if caja.save
      opciones = {location: edit_caja_path(caja)}
    else
      opciones = {}
    end
    respond_with caja, opciones
  end

  def update
    caja.update_attributes params[:caja]
    respond_with caja, location: edit_caja_path(caja)
  end

  def destroy
    respond_with caja
  end

private
  def paginas
    @paginas ||= PaginaDecorator.decorate Pagina.publicadas.por_orden
  end

  def caja
    @caja ||= find_or_new_caja
  end

  helper_method :caja, :paginas
end
