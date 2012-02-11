# encoding: utf-8

class CajaDecorator < ApplicationDecorator
  decorates :caja

  def thumbnail
    resized_image 300, alt: model.to_s
  end
end
