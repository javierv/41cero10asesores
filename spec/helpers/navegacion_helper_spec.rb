# encoding: utf-8

require 'spec_helper'

describe NavegacionHelper do
  describe "#lista_con_enlaces" do
    it "devuelve nada pasándole nada" do
      helper.lista_con_enlaces([]).should == ''
    end

    context "un enlace como URL" do
      let(:lista) { helper.lista_con_enlaces [['Posts', '/posts']] }

      it "genera una lista con un elemento" do
        lista.should have_selector 'ul', count: 1
        lista.should have_selector 'li', count: 1
      end

      it "genera un enlace" do
        lista.should have_selector 'li a', count: 1
        lista.should have_selector 'a[href="/posts"]'
        lista.should have_selector 'a', text: 'Posts'
      end
    end

    context "un enlace con opciones" do
      let(:lista) do
        helper.lista_con_enlaces [['Posts', '/posts', :class => :mejor]]
      end

      it "genera un enlace con las opciones indicadas" do
        lista.should have_selector 'a.mejor'
      end
    end

    context "incluyendo opciones de controlador" do
      let(:accion) do
        -> { helper.lista_con_enlaces [['Posts', '/posts', controller: :posts]] }
      end

      it "el enlace tiene la clase del controlador" do
        lista = accion[]
        lista.should have_selector "a.posts"
        lista.should_not have_selector "a.current"
      end

      it "el enlace se marca como actual si es el controlador actual" do
        helper.params[:controller] = :posts
        lista = accion[]
        lista.should have_selector "a.posts"
        lista.should have_selector "a.current"
      end
    end

    context "un enlace como formulario" do
      let(:lista) do
        helper.lista_con_enlaces [['Borrar', '/posts', form: true, method: :delete]]
      end

      it "genera un formulario" do
        lista.should have_selector 'li form[action="/posts"]', count: 1
      end

      it "cierra el formulario" do
        lista.should include "</form>"
      end

      it "genera un botón con el texto" do
        lista.should have_selector 'input[type="submit"][value="Borrar"]'
      end
    end
  end
end
