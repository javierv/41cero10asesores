# encoding: utf-8

class CajasController < ApplicationController
  respond_to :html

  before_filter :find_caja, :only => [:show, :edit, :update, :destroy]
  before_filter :new_caja, :only => [:new, :create]
  before_filter :update_caja, :only => :update

  def index
    @search = Caja.search params[:search]
    @cajas = @search.paginate :page => params[:page],
      :per_page => Caja.per_page
    respond_with @cajas
  end

  def show
    respond_with @caja
  end

  def new
    respond_with @caja
  end

  def edit
    respond_with @caja
  end

  def create
    flash[:notice] = 'Caja se creó correctamente.' if @caja.save
    respond_with @caja
  end

  def update
    flash[:notice] = 'Caja se actualizó correctamente.' if @caja.save
    respond_with @caja
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
