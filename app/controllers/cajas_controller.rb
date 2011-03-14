# encoding: utf-8

class CajasController < ApplicationController
  respond_to :js, only: [:index]
  respond_to :html

  resource :caja

  before_filter :find_caja, only: [:edit, :update, :destroy]
  before_filter :new_caja, only: [:new, :create]
  before_filter :update_caja, only: :update

  def index
    @search = Caja.search params[:search]
    @cajas = @search.page(params[:page])

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
    if @caja.save
      opciones = {location: edit_caja_path(@caja)}
    else
      opciones = {}
    end
    respond_with @caja, opciones
  end

  def destroy
    @caja.destroy
    respond_with @caja
  end

private
  def update_caja
    @caja.attributes = params[:caja]
  end
end
