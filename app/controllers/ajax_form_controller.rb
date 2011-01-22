# encoding: utf-8

class AjaxFormController < ApplicationController
  respond_to :js

  def autocomplete
    #TODO: mover al modelo
    modelo = params[:url].split('/')[1].singularize.classify.constantize
    campo_busqueda = /\[(.*)\]/.match(params[:name])[1]
    campo = campo_busqueda.sub('_contains', '').to_sym
    valores = params[:term].split(' ')
    @resultados = modelo.metasearch(:"#{campo_busqueda}_all" => valores).order(campo)

    json = @resultados.map do |resultado|
      {"id" => resultado.id, "label" => resultado.send(campo).truncate(50), "value" => resultado.send(campo)}
    end
    render :json => json
  end
end
