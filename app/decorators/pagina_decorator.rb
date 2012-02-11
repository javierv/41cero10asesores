# encoding: utf-8

class PaginaDecorator < ApplicationDecorator
  decorates :pagina

  def title_for_edit
    if model.borrador?
      "Editando borrador de #{model}"
    else
      "Editando la página #{model}"
    end
  end

  def etiqueta_con_enlace_a_editar
    "#{model} #{h.enlace_accion :edit, model}".html_safe
  end

  def tipo
    if borrador?
      'Borrador'
    else
      'Publicada'
    end
  end

  def cuerpo
    textilize model.cuerpo
  end

  def highlight(term)
    h.search_highlight textilize(cuerpo_truncado 500), term
  end

  def title_link_highlight(term)
    h.link_to h.search_highlight(model.display_name, term), model
  end

  def diferencias(pagina)
    differ render_pagina, pagina.render_pagina
  end

  def save_draft_path
    if model.new_record?
      h.save_draft_paginas_path
    else
      h.save_draft_pagina_path(model)
    end
  end

  def preview_path
    if model.new_record?
      h.preview_paginas_path
    else
      h.preview_pagina_path(model)
    end
  end

  def versions_actions_list(version)
    lista_de_acciones [:historial, recover_version_action(version)]
  end

  def texto_actualizado
    unless model.new_record?
      "Página guardada el #{updated_at}".html_safe
    end
  end

protected
  def render_pagina
    h.render('paginas/texto_pagina', pagina: self)
  end

private
  def differ(actual, anterior)
    Differ.diff(actual, anterior).to_s.html_safe
  end

  def acciones
    [show_action, :edit, :destroy, :historial, edit_draft_action].compact
  end

  def show_action
    :show unless model.borrador?
  end

  def edit_draft_action
    if model.has_draft?
      ["Editar borrador", h.edit_pagina_path(model.draft), {class: "draft"}]
    end
  end

  def recover_version_action(version)
    ['Recuperar', h.recover_vestal_versions_version_path(version),
      {form: true, method: :put}]
  end
end
