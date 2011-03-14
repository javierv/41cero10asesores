# encoding: utf-8

class CajasController < ApplicationController
  respond_to :js, only: [:index]
  respond_to :html

  resource :caja

  before_filter :find_caja, only: [:edit, :update, :destroy]
  before_filter :new_caja, only: [:new, :create]
  before_filter :update_caja, only: :update
  before_filter :paginate_cajas, only: :index

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
    @caja.destroy
    respond_with @caja
  end

private
  def update_caja
    @caja.attributes = params[:caja]
  end
end
