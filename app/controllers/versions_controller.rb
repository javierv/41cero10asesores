# encoding: utf-8

class VersionsController < ApplicationController
  before_filter :find_version
  before_filter :reify_pagina, :except => :restore

  def show
  end

  def recover
    @pagina.save
    redirect_to @pagina, :notice => 'Versión recuperada'
  end

  def restore
    @version.restore!
    redirect_to paginas_path, :notice => 'Página recuperada'
  end

  def compare
    @referencia =
      if params[:ref_id]
        VestalVersions::Version.find(params[:ref_id])
      else
        @version.current
      end
  end

private
  def find_version
    @version = VestalVersions::Version.find(params[:version_id] || params[:id])
  end

  def reify_pagina
    @pagina = @version.reify
  end
end
