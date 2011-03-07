# encoding: utf-8

require "spec_helper"

describe BoletinMailer do
  describe "envío boletín" do
    subject do
      BoletinMailer.envio Factory(:boletin,
        destinatarios: "Pedro <pedro@calesur.es>,Juan <juan@calesur.es>",
        archivo: File.new("spec/images/example.pdf"))
    end

    its(:bcc) { should == %w(pedro@calesur.es juan@calesur.es) }
    its(:attachments) { should have(1).item }
    its("attachments.first.filename") { should == "example.pdf" }
  end
end
