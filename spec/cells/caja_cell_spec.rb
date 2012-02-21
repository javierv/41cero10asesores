# encoding: utf-8

require "spec_helper"

describe CajaCell do
  # Si uso decoradores desde aquí, falla cuando
  # los decoradores llaman métodos de ayudantes
  let(:caja) { Factory(:caja) }
  before(:each) { caja.stubs(admin_actions_list: "Admin") }

  describe "completa" do
    context "sin usuario identificado" do
      subject { render_cell :caja, :completa, caja }
      it { should have_selector "article" }
    end

    context "con usuario identificado" do
      before(:each) { authenticate_usuario }
      subject { render_cell :caja, :completa, caja }
      it { should have_selector "article" }
    end
  end

  describe "contenido" do
    context "caja sin imagen" do
      subject { render_cell :caja, :contenido, caja }
      it { should have_selector "header" }
    end

    context "caja con imagen" do
      let(:caja) { Factory(:caja, imagen_uid: "blank.png") }
      before(:each) { caja.stubs(thumbnail: "") }
      subject { render_cell :caja, :contenido, caja }
      it { should have_selector "figure" }
    end
  end

  describe "caché", cache: true do
    subject { cell(:caja) }
    it { should cache :contenido, caja }
  end
end
