# encoding: utf-8

require "spec_helper"

describe BoletinMailer do
  describe "envío boletín" do
    subject do
      BoletinMailer.envio Factory(:boletin,
        destinatarios: "Pedro <pedro@calesur.es>, Julián <julian@calesur.es>",
        archivo: File.new("spec/images/example.pdf"),
        titulo: "Aventuras nuevas")
    end

    its(:from) { should == ["info@calesur.com"] }
    its(:subject) { should == "Aventuras nuevas" }
    its(:bcc) { should == %w(pedro@calesur.es julian@calesur.es) }
    its(:attachments) { should have(1).item }
    its("attachments.first.filename") { should == "example.pdf" }
  end
end
