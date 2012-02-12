# encoding: utf-8

require 'spec_helper'

describe AjaxFormController do
  include Rails.application.routes.url_helpers

  def default_url_options
    { only_path: true }
  end

  let(:url) { url_for controller: :paginas, action: :index }
  before(:each) { authenticate_usuario }

  context 'pidiendo con la URL del índice' do
    before(:each) do
      xhr :get, :autocomplete, name: "search[titulo_contains]", term: 'ul', url: url
    end

    it { should respond_with(:success) }
  end
end    
