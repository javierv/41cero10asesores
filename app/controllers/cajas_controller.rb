# encoding: utf-8

class CajasController < ApplicationController
  respond_to :js, only: [:index]
  respond_to :html

  before_filter :find_caja, only: [:edit, :update, :destroy]
  before_filter :new_caja, only: [:new, :create]
  before_filter :update_caja, only: :update

  def index
    @search = Caja.search params[:search]
    # HACK: kaminari y metasearch no se llevan bien.
    @cajas = @search.where(true).page(params[:page])

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
      flash[:notice] = 'Caja se creó correctamente.'
      opciones = {location: edit_caja_path(@caja)}
    else
      opciones = {}
    end
    respond_with @caja, opciones
  end

  def update
    flash[:notice] = 'Caja se actualizó correctamente.'
    if @caja.save
      opciones = {location: edit_caja_path(@caja)}
    else
      opciones = {}
    end
    respond_with @caja, opciones
  end

  def destroy
    flash[:notice] = 'Caja se borró correctamente.' if @caja.destroy
    respond_with @caja
  end

private
  def find_caja
    @caja = Caja.find(params[:id])
  end

  def new_caja
    @caja = Caja.new(params[:caja])
  end

  def update_caja
    @caja.attributes = params[:caja]
  end
end
