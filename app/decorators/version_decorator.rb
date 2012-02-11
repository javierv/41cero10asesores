# encoding: utf-8

class VersionDecorator < ApplicationDecorator
  decorates :version, class: VestalVersions::Version

  def borradas_actions_list
    lista_de_acciones [[:restore,  {form: true, method: :put}]]
  end

private
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
