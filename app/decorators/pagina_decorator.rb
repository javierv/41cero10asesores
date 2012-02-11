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

private
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
