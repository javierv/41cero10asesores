# encoding: utf-8

require 'spec_helper'

def new_post_path
  "/posts/my_new"
end

def post_path(post)
  "/posts/35"
end

def posts_path
  "/posts"
end

describe ApplicationDecorator do
  describe "#actions_lists" do
    class Post
      extend ActiveModel::Naming
    end

    let(:post) { ApplicationDecorator.decorate Post.new }

    context "show action" do
      subject { post.actions_list [:show] }

      it "genera una lista con la clase de acciones" do
        subject.should have_selector "ul.actions"
      end

      it "genera un enlace a mostrar" do
        subject.should have_selector "a[href='#{post_path(post)}']"
      end
    end

    context "destroy action" do
      subject { post.actions_list [:destroy] }

      it "genera un enlace a borrar" do
        subject.should have_selector "a[href='#{post_path(post)}']"
        subject.should have_selector "a[data-method='delete']"
      end
    end

    context "index action" do
      subject { post.actions_list [:index] }
      it "genera un enlace al índice" do
        subject.should have_selector "a[href='#{posts_path}']"
      end
    end

    context "new action" do
      subject { post.actions_list [:new] }
      it "genera un enlace a nuevo" do
        subject.should have_selector "a[href='#{new_post_path}']"
      end
    end

    context "pasando un array" do
      subject { post.actions_list [["Posts", "/posts"]] }
      it "genera como un enlace normal" do
        subject.should have_selector "a[href='/posts']", text: "Posts"
      end
    end
  end
end
