# encoding: utf-8

class BoletinDecorator < ApplicationDecorator
  decorates :boletin

  def filename
    archivo_name.force_encoding("utf-8")
  end

private
  def acciones
    [:show, :edit, :destroy, (:enviar unless model.enviado?)].compact
  end
end
