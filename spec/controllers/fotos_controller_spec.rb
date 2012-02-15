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
        xhr :post, :create, foto: foto.attributes
      end

      it do
        should respond_with(:success)
        should respond_with_content_type(:js)
        should_not set_the_flash
        should render_template(:create)
      end
    end

    context "with an invalid model" do
      before(:each) do
        falla_validacion Foto
        xhr :post, :create
      end

      it do
        should respond_with(:success)
        should respond_with_content_type(:js)
        should render_template(:error)
      end
    end
  end

  describe "thumbnail" do
    before(:each) do
      xhr :get, :thumbnail, id: foto.to_param, foto: { imagen_width: 300 }
    end

    it { should respond_with(:success) }
  end
end
