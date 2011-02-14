# encoding: utf-8

class FotosController < ApplicationController
  respond_to :js

  def create
    @foto = Foto.new params[:foto]
    if @foto.save
      flash[:notice] = 'Foto se creó correctamente.'
    else
      flash[:alert] = 'Error al crear la foto'
      render 'error'
    end
  end

  def thumbnail
    @foto = Foto.find params[:id]
    @size = params[:foto][:imagen_width]
  end
end
