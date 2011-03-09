# encoding: utf-8

class FotosController < ApplicationController
  respond_to :js
  resource :foto
  before_filter :find_foto, only: :thumbnail
  before_filter :new_foto, only: :create

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
end
