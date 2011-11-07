# encoding: utf-8

class BoletinMailer < ActionMailer::Base
  default from: APP_CONFIG["email"]

  def envio(boletin)
    attachments[boletin.archivo_name] = boletin.archivo.data
    mail(bcc: boletin.destinatarios, subject: boletin.titulo)
  end
end
