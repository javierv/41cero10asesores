# encoding: utf-8

class CajaCell < ApplicationCell
  build { AdminCajaCell if usuario_signed_in? }

  cache :contenido do |cell, caja|
    caja
  end

  cache :sidebar do |cell, cajas|
    cajas
  end

  def completa(caja)
    render locals: { caja: caja }
  end

  def contenido(caja)
    if caja.imagen?
      render view: :imagen, locals: { caja: caja }
    else
      render view: :texto, locals: { caja: caja }
    end
  end

  def sidebar(cajas)
    render locals: { cajas: cajas }
  end
end

class AdminCajaCell < CajaCell
  def contenido(caja)
    super(caja) + render(view: :actions_list, locals: { caja: caja })
  end
end
