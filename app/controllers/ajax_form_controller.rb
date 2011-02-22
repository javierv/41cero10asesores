# encoding: utf-8

require 'filter'

class AjaxFormController < ApplicationController
  respond_to :js

  def autocomplete
    @resultados = modelo.filter params[:name], params[:term]

    json = @resultados.map do |resultado|
      resultado.to_autocomplete params[:name]
    end
    render json: json
  end

private
  def modelo
    Rails.application.routes.recognize_path(params[:url])[:controller].classify.constantize
  end
end
