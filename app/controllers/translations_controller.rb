# encoding: utf-8

class TranslationsController < ApplicationController
  expose(:translations) { TRANSLATION_STORE }

  def index
  end

  def create
    translations.store_public_translations(params[:translation], escape: false)
    redirect_to translations_url, notice: "Traducciones guardadas"
  end
end
