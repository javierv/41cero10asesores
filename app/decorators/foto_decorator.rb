class FotoDecorator < ApplicationDecorator
  decorates :foto

  def thumbnail
    h.image_tag resized_url(100)
  end

  def resized_url(size)
    resize(size).url
  end

private
  def resize(size)
    model.imagen.thumb("#{size}x#{size}#")
  end
end
