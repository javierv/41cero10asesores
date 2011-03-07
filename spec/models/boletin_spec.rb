# encoding: utf-8

require 'spec_helper'

describe Boletin do
  it { should validate_presence_of(:archivo) }

  describe "enviado" do
    it "es falso por defecto" do
      Boletin.new.enviado?.should be_false
    end
  end
end
