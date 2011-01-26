class VersionsController < ApplicationController
  before_filter :find_version
  before_filter :reify_pagina

  def show
  end

  def recover
    @pagina.save
    redirect_to @pagina, :notice => 'Versión recuperada'
  end

private
  def find_version
    @version = Version.find params[:id]
  end

  def reify_pagina
    @pagina = @version.reify
  end
end
