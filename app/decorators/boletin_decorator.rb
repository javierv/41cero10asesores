# encoding: utf-8

class BoletinDecorator < ApplicationDecorator
  decorates :boletin

  def filename
    archivo_name.force_encoding("utf-8")
  end

  def destinatarios_check_boxes
    model.clientes.map.with_index do |cliente, index|
      id = "boletin_destinatarios_#{index}"
      h.content_tag :div, class: "input boolean" do
        h.check_box_tag("boletin[clientes][]", cliente, true, id: id) +
        h.label_tag(id, cliente)
      end
    end.join.html_safe
  end

private
  def acciones
    [:show, :edit, :destroy, (:enviar unless model.enviado?)].compact
  end
end
