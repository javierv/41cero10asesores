# encoding: utf-8

class BoletinMailer < ActionMailer::Base
  default :from => "from@example.com"

  def envio(boletin)
    attachments[boletin.archivo.name] = boletin.archivo.data
    mail(bcc: boletin.destinatarios)
  end
end
