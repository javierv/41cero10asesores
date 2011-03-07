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
end
