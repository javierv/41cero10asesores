module FotosHelper
  def thumbnail(foto)
    link_to image_tag(foto.imagen.thumb('100x100#').url), foto.imagen.url
  end
end
