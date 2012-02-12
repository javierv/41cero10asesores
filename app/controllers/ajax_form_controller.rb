# encoding: utf-8

class AjaxFormController < ApplicationController
  respond_to :js

  def autocomplete
    render json: resultados.map { |result| result.to_autocomplete params[:name] }
  end

private
  def modelo
    Rails.application.routes.recognize_path(params[:url])[:controller].classify.constantize
  end

  def resultados
    modelo.filter params[:name], params[:term]
  end
end
