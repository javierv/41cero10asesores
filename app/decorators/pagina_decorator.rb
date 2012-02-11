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

private
  def cuerpo_truncado
    h.truncate model.cuerpo, length: 500, separator: ' '
  end

  def acciones
    acciones = [:show, :edit, :destroy, :historial]

    if model.has_draft?
      acciones.push ["Editar borrador", h.edit_pagina_path(model.draft), {class: "draft"}]
    end

    if pagina.borrador?
      acciones.shift
    end

    acciones
  end
end
