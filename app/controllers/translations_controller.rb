# encoding: utf-8

class TranslationsController < ApplicationController
  def index
    @translations = TRANSLATION_STORE
  end

  def create
    params[:translations].each do |key, value|
      I18n.backend.store_translations(I18n.locale, public: {key => value}, escape: false)
    end
    redirect_to translations_url, notice: "Traducciones guardadas"
  end
end
