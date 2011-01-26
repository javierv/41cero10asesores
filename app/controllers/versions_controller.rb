class VersionsController < ApplicationController
  before_filter :find_version
  before_filter :reify_pagina

  def show
  end

  def recover
    @pagina.save
    redirect_to @pagina, :notice => 'Versión recuperada'
  end

  def compare
    @previa = @version.versioned
    @previa.revert_to(@version.number - 1)
  end

private
  def find_version
    @version = VestalVersions::Version.find params[:id]
  end

  def reify_pagina
    @pagina = @version.versioned
    @pagina.revert_to(@version.number)
  end
end
