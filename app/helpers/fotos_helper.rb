module FotosHelper
  def thumbnail(foto)
    image_tag foto.imagen.url
  end
end
