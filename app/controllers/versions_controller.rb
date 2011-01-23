class VersionsController < ApplicationController
  def show
    version = Version.find params[:id]
    @pagina = version.reify
  end
end
