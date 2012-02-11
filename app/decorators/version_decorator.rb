# encoding: utf-8

class VersionDecorator < ApplicationDecorator
  decorates :version, class: VestalVersions::Version

  def borradas_actions_list
    lista_de_acciones [[:restore,  {form: true, method: :put}]]
  end

  def botones_seleccion_diferencias
    boton_referencia + boton_id
  end

  def texto_version_modificada
    [texto_fecha_modificacion, texto_autor_modificacion].compact.join(" ").html_safe
  end

private
  def boton_referencia
    h.radio_button_tag :ref_id, model.id, false,
                     title: 'Selecciona como versión de referencia en la comparación'
  end

  def boton_id
    h.radio_button_tag :version_id, model.id, false,
                     title: 'Selecciona como versión posterior en la comparación'
  end

  def texto_fecha_modificacion
    "Modificada el #{h.content_tag :span, updated_at}"
  end

  def texto_autor_modificacion
    if model.user
      "por #{h.content_tag :span, model.user}"
    end
  end

  def acciones
    [:show, previous_action, current_action].compact
  end

  def previous_action
    if model.previous
      ['Anterior',
        h.compare_vestal_versions_version_path(model, model.previous),
        {title: 'Comparar con la versión anterior a esta'}]
    end
  end

  def current_action
    unless model.current?
      ['Actual', h.compare_vestal_versions_version_path(model),
        {title: 'Comparar con la versión actual'}]
    end
  end
end
