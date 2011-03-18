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

  describe "#actions_lists" do
    class Post
      extend ActiveModel::Naming
    end

    def new_post_path
      '/posts/my_new'
    end

    def post_path(post)
      '/posts/35'
    end

    def posts_path
      '/posts'
    end

    let(:post) { Post.new }

    def lista_una_accion(accion)
      actions_list [accion], post
    end

    it "genera una lista con la clase de acciones" do
      lista_una_accion(:show).should have_selector "ul.actions"
    end

    it "la acción mostrar genera un enlace a mostrar" do
      lista_una_accion(:show).should have_selector "a[href='#{post_path(post)}']"
    end

    it "la acción destroy genera un enlace a borrar" do
      lista_una_accion(:destroy).should have_selector "a[href='#{post_path(post)}']"
      lista_una_accion(:destroy).should have_selector "a[data-method='delete']"
    end

    it "la acción índice genera un enlace al índice" do
      lista_una_accion(:index).should have_selector "a[href='#{posts_path}']"
    end

    it "la acción nueva genera un enlace a nuevo" do
      lista_una_accion(:new).should have_selector "a[href='#{new_post_path}']"
    end

    it "genera como un enlace normal si se pasa un array" do
      actions_list([['Posts', '/posts']], post).should have_selector(
        "a[href='/posts']", text: 'Posts')
    end
  end
end
