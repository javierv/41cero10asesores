# encoding: utf-8

class PaginasController < ApplicationController
  respond_to :html

  before_filter :find_pagina, :only => [:show, :edit, :update, :destroy]
  before_filter :new_pagina, :only => [:new, :create]
  before_filter :asignar_cajas, :only => [:create, :update]

  def index
    @search = Pagina.search params[:search]
    @paginas = @search.paginate :page => params[:page],
      :per_page => Pagina.per_page
    respond_with @paginas
  end

  def show
    respond_with @pagina
  end

  def new
    respond_with @pagina
  end

  def edit
    respond_with @pagina
  end

  def create
    flash[:notice] = 'Pagina se creó correctamente.' if @pagina.save
    respond_with @pagina
  end

  def update
    flash[:notice] = 'Pagina se actualizó correctamente.' if @pagina.update_attributes(params[:pagina])
    respond_with @pagina
  end

  def destroy
    flash[:notice] = 'Pagina se borró correctamente.' if @pagina.destroy
    respond_with @pagina
  end

private
  def find_pagina
    @pagina = Pagina.find(params[:id])
  end

  def new_pagina
    @pagina = Pagina.new(params[:pagina])
  end

  def asignar_cajas
    if params[:pagina][:caja_ids]
      @pagina.ids_cajas = params[:pagina][:caja_ids]
    end
  end
end
