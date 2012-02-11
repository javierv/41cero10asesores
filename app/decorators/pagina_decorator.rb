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
    h.search_highlight textilize(cuerpo_truncado), term
  end

  def title_link_highlight(term)
    h.link_to h.search_highlight(model.display_name, term), model
  end

  def diferencias(pagina)
    differ render_pagina, pagina.render_pagina
  end

protected
  def render_pagina
    h.render('paginas/texto_pagina', pagina: self)
  end

private
  def differ(actual, anterior)
    Differ.diff(actual, anterior).to_s.html_safe
  end

  def cuerpo_truncado
    h.truncate model.cuerpo, length: 500, separator: ' '
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
end
