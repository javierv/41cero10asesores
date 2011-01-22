# encoding: utf-8

module FotosHelper
  def thumbnail(foto)
    image_tag(foto.imagen.thumb('100x100#').url)
  end
end
