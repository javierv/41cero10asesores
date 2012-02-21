# encoding: utf-8

class CajaCell < ApplicationCell
  build { AdminCajaCell if usuario_signed_in? }

  cache(:contenido) { |cell, caja| caja }
  # Es un proxy de decoradores. ¿Cómo salvar esto?
  cache(:sidebar) { |cell, cajas| cajas.map(&:model) }

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
