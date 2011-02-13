# encoding: utf-8

class AjaxFormController < ApplicationController
  respond_to :js

  def autocomplete
    @resultados = modelo.metasearch(:"#{campo_busqueda}_all" => valores).order(campo)

    json = @resultados.map do |resultado|
      {"id" => resultado.id, "label" => resultado.send(campo).truncate(50), "value" => resultado.send(campo)}
    end
    render json: json
  end

private
  #TODO: mover al modelo
  def modelo
    params[:url].split('/')[1].singularize.classify.constantize
  end

  def campo_busqueda
    @campo_busqueda ||= /\[(.*)\]/.match(params[:name])[1]
  end

  def campo
    @campo ||= campo_busqueda.sub('_contains', '').to_sym
  end

  def valores
    params[:term].split(' ')
  end
end
