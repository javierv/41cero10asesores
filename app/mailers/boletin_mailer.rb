# encoding: utf-8

class BoletinMailer < ActionMailer::Base
  default :from => "boletines@calesur.com"

  def envio(boletin)
    attachments[boletin.archivo.name] = boletin.archivo.data
    mail(bcc: boletin.destinatarios, subject: boletin.titulo)
  end
end
