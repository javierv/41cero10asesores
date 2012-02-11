# encoding: utf-8

class ApplicationDecorator < Draper::Base
  delegate :to_s, to: :model

  def resized_image(size, options = {})
    h.image_tag resized_url(size), options
  end

  def resized_url(size)
    resize(size).url
  end

  def actions_list
    lista_de_acciones acciones
  end

private
  def lista_de_acciones(acciones)
    h.actions_list acciones, model
  end

  def resize(size)
    model.imagen.thumb("#{size}x#{size}#")
  end
end
