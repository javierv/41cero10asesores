# encoding: utf-8

class BoletinDecorator < ApplicationDecorator
  decorates :boletin

  def filename
    archivo_name.force_encoding("utf-8")
  end

private
  def acciones
    acciones = [:show, :edit, :destroy]
    acciones << :enviar unless boletin.enviado?
    acciones
  end
end
