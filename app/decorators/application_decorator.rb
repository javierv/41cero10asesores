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

  def error_messages
    if model.errors.any?
      h.content_tag :div, id: "error_messages" do
        h.content_tag(:h2, texto_numero_errores) + lista_errores
      end
    end
  end

  def deshacer_borrado_path
    h.restore_vestal_versions_version_path model.versions.last
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

  def texto_numero_errores
    "#{h.pluralize model.errors.count, "error"} al rellenar el formulario:"
  end

  def lista_errores
    h.content_tag :ul do
      model.errors.map do |field, msg|
        h.content_tag :li, link_to_error(field, msg)
      end.join.html_safe
    end
  end

  def link_to_error(field, msg)
    h.link_to "#{human_name(field)} #{msg}", "##{error_html_id(field)}"
  end

  def human_name(field)
    model.class.human_attribute_name field
  end

  def error_html_id(field)
    "#{model.class.to_s.downcase}_#{field}"
  end
end
