class FotoDecorator < ApplicationDecorator
  decorates :foto

  def thumbnail
    h.image_tag(model.imagen.thumb('100x100#').url)
  end
end
