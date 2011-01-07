require 'test_helper'

class AjaxFormControllerTest < ActionController::TestCase
  context 'Pidiendo páginas con título' do
    setup do
      ['título', 'mulo', 'web', 'css', 'pulómetro', 'html'].each do |titulo|
        Factory :pagina, :titulo => titulo
      end      
    end

    context 'pidiendo con la URL del índice' do
      setup do
        xhr :get, :autocomplete,
            :name => 'search[titulo_contains]', :term => 'ul', :url => '/paginas'
      end

      should 'devolver lista de resultados' do
        assert_equal ['mulo', 'pulómetro', 'título'], assigns(:resultados)
      end
    end

    context 'pidiendo con la URL con la acción' do
      setup do
        xhr :get, :autocomplete,
            :name => 'search[titulo_contains]', :term => 'ul', :url => '/paginas/index'
      end

      should 'devolver lista de resultados' do
        assert_equal ['mulo', 'pulómetro', 'título'], assigns(:resultados)
      end
    end

    context 'con varias palabras' do
      setup do
         xhr :get, :autocomplete,
          :name => 'search[titulo_contains]', :term => 'ul t', :url => '/paginas'
      end

      should 'devolver los que contienen todos los términos' do
        assert_equal ['pulómetro', 'título'], assigns(:resultados)
      end
    end
  end    
end
