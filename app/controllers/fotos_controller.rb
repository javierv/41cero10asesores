# encoding: utf-8

class FotosController < ApplicationController
  respond_to :html
  before_filter :new_foto, only: [:new, :create]

  def new
    respond_with @foto
  end

  def create
    if @foto.save
      flash[:notice] = 'Foto se creó correctamente.'
      opciones = {location: new_foto_path}
    else
      opciones = {}
    end

    if request.xhr?
      render 'create.js'
    else
      respond_with @foto, opciones
    end
  end

  def thumbnail
    @foto = Foto.find params[:id]
    @size = params[:foto][:imagen_width]

    if request.xhr?
      render 'thumbnail.js'
    end
  end

private
  def new_foto
    @foto = Foto.new(params[:foto])
  end
end
