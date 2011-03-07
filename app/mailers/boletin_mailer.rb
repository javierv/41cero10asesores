# encoding: utf-8

class BoletinMailer < ActionMailer::Base
  default :from => "from@example.com"

  def envio(boletin)
    mail(bcc: boletin.destinatarios)
  end
end
