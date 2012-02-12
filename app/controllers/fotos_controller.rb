# encoding: utf-8

class FotosController < ApplicationController
  respond_to :js
  resource :foto

  expose(:foto) { find_or_new_foto }
  expose(:size) { params[:foto][:imagen_width] }

  def create
    if foto.save
      respond_with foto
    else
      render 'error'
    end
  end

  def thumbnail
  end
end
