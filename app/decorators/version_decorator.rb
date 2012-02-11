# encoding: utf-8

class VersionDecorator < ApplicationDecorator
  decorates :version, class: VestalVersions::Version

  def borradas_actions_list
    lista_de_acciones [[:restore,  {form: true, method: :put}]]
  end

  def botones_seleccion_diferencias
    boton_referencia + boton_id
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

  def acciones
    actions = [:show]

    if version.previous
      actions << ['Anterior',
                h.compare_vestal_versions_version_path(version, version.previous),
                {title: 'Comparar con la versión anterior a esta'}]
    end

    unless version.current?
      actions << ['Actual', h.compare_vestal_versions_version_path(version),
                  {title: 'Comparar con la versión actual'}]
    end

    actions
  end
end
