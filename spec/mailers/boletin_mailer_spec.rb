# encoding: utf-8

require "spec_helper"

describe BoletinMailer do
  describe "envío boletín" do
    let(:email) do
      BoletinMailer.envio Factory(:boletin,
        destinatarios: "Pedro <pedro@calesur.es>,Juan <juan@calesur.es>",
        archivo: File.new("spec/images/example.pdf"))
    end

    it "envía a los clientes con copia oculta" do
      email.bcc.should == %w(pedro@calesur.es juan@calesur.es)
    end 
  end
end
