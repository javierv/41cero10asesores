# encoding: utf-8

require 'spec_helper'

describe FotosController do
  let(:foto) { Factory :foto }
  before(:each) do
    authenticate_usuario
  end

  describe "create" do
    context "with a valid model" do
      before(:each) do
        valida_siempre Foto
        xhr :post, :create
      end

      it { assigns(:foto).should be_true }
      it { should respond_with(:success) }
      it { should_not set_the_flash }
    end

    context "with an invalid model" do
      before(:each) do
        falla_validacion Foto
        xhr :post, :create
      end

      it { assigns(:foto).should be_true }
      it { should respond_with(:success) }
      it { should render_template(:error) }
    end
  end

  describe "thumbnail" do
    before(:each) do
      xhr :get, :thumbnail, id: foto.to_param, foto: { imagen_width: 300 }
    end

    it { assigns(:foto).should be_true }
    it { assigns(:size).should be_true }
    it { should respond_with(:success) }
  end
end
