# encoding: utf-8

class FotosController < ApplicationController
  respond_to :js

  def create
    @foto = Foto.new params[:foto]
    unless @foto.save
      render 'error'
    end
  end

  def thumbnail
    @foto = Foto.find params[:id]
    @size = params[:foto][:imagen_width]
  end
end
