class AjaxFormController < ApplicationController
  respond_to :js

  def autocomplete
    modelo = params[:url].split('/')[1].singularize.classify.constantize
    campo_busqueda = /\[(.*)\]/.match(params[:name])[1]
    campo = campo_busqueda.sub('_contains', '').to_sym
    valores = params[:term].split(' ')
    @resultados = modelo.metasearch(:"#{campo_busqueda}_all" => valores).order(campo).collect(&campo)
  end
end
