# encoding: utf-8

class FotoDecorator < ApplicationDecorator
  decorates :foto

  def thumbnail
    resized_image 100
  end
end
