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

  def created_at
    time_tag model.created_at
  end

  def updated_at
    time_tag model.updated_at
  end

  def textilize(texto)
    # Mantenemos este ayudante en vez de pasarlo aquí, porque
    # lo usamos en la página de ayuda del editor.
    h.strict_textilize(texto)
  end

  def principio_cuerpo
    cuerpo_truncado 50
  end

private
  def lista_de_acciones(acciones)
    h.actions_list acciones, model
  end

  def resize(size)
    model.imagen.thumb("#{size}x#{size}#")
  end

  def time_tag(date)
    h.content_tag :time, format_date(date), datetime: datetime_attr(date)
  end

  def format_date(date)
    h.l(date, format: :long)
  end

  def datetime_attr(date)
    if date.acts_like?(:time)
      date.xmlschema
    else
      date.rfc3339
    end
  end

  def cuerpo_truncado(length)
    h.truncate model.cuerpo, length: length, separator: ' '
  end
end
