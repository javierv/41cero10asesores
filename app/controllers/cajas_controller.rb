# encoding: utf-8

class CajasController < ApplicationController
  respond_to :js, only: [:index, :destroy]
  respond_to :html

  resource :caja

  before_filter :find_caja, only: [:edit, :update, :destroy]
  before_filter :new_caja, only: [:new, :create]
  before_filter :update_caja, only: :update
  before_filter :paginate_cajas, only: :index
  before_filter :set_paginas, only: [:new, :edit]

  def index
    respond_with @cajas
  end

  def new
    respond_with @caja
  end

  def edit
    respond_with @caja
  end

  def create
    if @caja.save
      opciones = {location: edit_caja_path(@caja)}
    else
      opciones = {}
    end
    respond_with @caja, opciones
  end

  def update
    @caja.save
    respond_with @caja, location: edit_caja_path(@caja)
  end

  def destroy
    if @caja.destroy
      @deshacer = deshacer_borrado_path(@caja)
      @siguiente = next_caja if request.xhr?
    end
    respond_with @caja
  end

private
  def update_caja
    @caja.attributes = params[:caja]
  end

  def set_paginas
    @paginas = PaginaDecorator.decorate Pagina.publicadas.por_orden
  end
end
