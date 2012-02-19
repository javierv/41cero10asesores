# encoding: utf-8

class CajaDecorator < ApplicationDecorator
  decorates :caja

  def thumbnail
    resized_image 300, alt: model.to_s
  end

  def miniatura
    resized_image 100, alt: model.to_s
  end

  def cuerpo
    textilize model.cuerpo
  end

private
  def acciones
    [:edit, :destroy]
  end
end
