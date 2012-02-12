# encoding: utf-8

class FotosController < ApplicationController
  respond_to :js
  resource :foto

  def create
    if foto.save
      respond_with foto
    else
      render 'error'
    end
  end

  def thumbnail
  end

private
  def foto
    @foto ||= find_or_new_foto
  end

  def size
    @size ||= params[:foto][:imagen_width]
  end

  helper_method :foto, :size
end
