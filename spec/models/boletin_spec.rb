# encoding: utf-8

require 'spec_helper'

describe Boletin do
  it { should validate_presence_of(:archivo) }

  describe "enviado" do
    it "es falso por defecto" do
      Boletin.new.enviado?.should be_false
    end
  end

  describe "enviar" do
    let(:boletin) { Factory :boletin }

    context "sin parámetros indicados" do
      before(:each) { boletin.enviar }

      it "marca el boletín como enviado" do
        boletin.enviado?.should be_true
      end

      it "no envía un boletín ya enviado" do
        boletin.enviar.should be_false
        boletin.errors.should_not be_empty
      end

      it "indica éxito" do
        Factory(:boletin).enviar.should be_true
      end
    end

    context "pasando clientes" do
       before(:each) do
         boletin.enviar clientes: ["Rafa <rafa@calesur.com>","Inés <ines@calesur.com>"]
       end

       it "asigna destinatarios" do
         boletin.destinatarios.should == "Rafa <rafa@calesur.com>, Inés <ines@calesur.com>"
       end
    end
  end

  describe "clientes" do
    let(:boletin) do
      Factory :boletin,
        destinatarios: "María <maria@calesur.com>, Teresa <teresa@calesur.com>"
    end

    it "devuelve array vacío para boletín sin destinatarios" do
      Boletin.new.clientes.should == []
    end

    it "tiene clientes" do
      boletin.clientes.should == ["María <maria@calesur.com>", "Teresa <teresa@calesur.com>"]
    end

    it "asigna clientes" do
      boletin.clientes = ["Ana <ana@calesur.com>", "Carmen <carmen@calesur.com>"]
      boletin.destinatarios.should == "Ana <ana@calesur.com>, Carmen <carmen@calesur.com>"
    end
  end
end
