# encoding: utf-8

class CajaCell < Cell::Rails
  def display(caja)
    render locals: { caja: caja }
  end

  def contenido(caja)
    if caja.imagen?
      render view: :imagen, locals: { caja: caja }
    else
      render view: :texto, locals: { caja: caja }
    end
  end
end
