# encoding: utf-8

class Boletin < ActiveRecord::Base
  attr_accessible :titulo, :archivo, :clientes
  display_name :titulo
  image_accessor :archivo

  validates :titulo, presence: true
  validates :archivo, presence: true
  validates_property :mime_type, of: :archivo, in: %w(application/pdf),
    message: "Tiene que ser un PDF"

  def enviar(params = {})
    if enviado?
      errors.add(:enviado, "ya está enviado")
      false
    else
      self.attributes = attributes.merge(params)
      BoletinMailer.envio(self).deliver
      self.enviado = true
      save
    end   
  end

  def clientes
    return [] if destinatarios.nil?
    destinatarios.split(", ")
  end

  def clientes=(emails)
    self.destinatarios = emails.join(", ")
  end
end
