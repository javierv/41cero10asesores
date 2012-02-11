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
end
