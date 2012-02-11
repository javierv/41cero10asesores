# encoding: utf-8

class FotosController < ApplicationController
  respond_to :js
  resource :foto
  before_filter :find_foto, only: :thumbnail
  before_filter :new_foto_decorator, only: :create

  def create
    if @foto.save
      respond_with @foto
    else
      render 'error'
    end
  end

  def thumbnail
    @size = params[:foto][:imagen_width]
  end

private
  def new_foto_decorator
    @foto = FotoDecorator.decorate new_foto
  end

  def find_foto
    @foto = FotoDecorator.find params[:id]
  end
end
