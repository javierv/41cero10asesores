# encoding: utf-8

require 'spec_helper'

describe AdminCell do
  describe "menu" do
    context "sin identificar" do
      subject { render_cell(:admin, :menu) }
      it { should_not have_selector("#admin") }
    end

    context "identificado" do
      before(:each) { authenticate_usuario }
      subject { render_cell(:admin, :menu) }
      it { should have_selector("#admin") }
    end
  end

  describe "cache", cache: true do
    specify { cell(:admin).should cache :menu }

    it "pone la caché en función del usuario" do
      render_cell(:admin, :menu).should_not have_selector("#admin")
      authenticate_usuario
      render_cell(:admin, :menu).should have_selector("#admin")
      sign_out @usuario
      render_cell(:admin, :menu).should_not have_selector("#admin")
    end
  end
end
