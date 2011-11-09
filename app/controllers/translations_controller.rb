# encoding: utf-8

class TranslationsController < ApplicationController
  def index
    @translations = TRANSLATION_STORE
  end

  def create
    TRANSLATION_STORE.store_public_translations(params[:translation], escape: false)
    redirect_to translations_url, notice: "Traducciones guardadas"
  end
end
