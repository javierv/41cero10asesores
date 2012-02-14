# encoding: utf-8

require 'spec_helper'

describe CabeceraCell do
  describe "logo" do
    subject { render_cell(:cabecera, :logo) }
    it { should have_selector("#logo") }
  end

  describe "access" do
    context "sin identificar" do
      subject { render_cell(:cabecera, :access) }
      it { should have_selector(".conectar") }
    end

    context "identificado" do
      before(:each) { authenticate_usuario }
      subject { render_cell(:cabecera, :access) }
      it { should have_selector(".desconectar") }
    end
  end

  describe "lema" do
    subject { render_cell(:cabecera, :lema) }
    it { should have_selector("#lema") }
  end
end
