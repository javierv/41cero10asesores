# encoding: utf-8

class VersionsController < ApplicationController
  respond_to :html
  before_filter :find_version, except: :borradas
  before_filter :reify_pagina, only: [:show, :recover, :compare]

  def show
  end

  def recover
    @pagina.save
    redirect_to @pagina, notice: 'Versión recuperada'
  end

  def restore
    @record = @version.restore!
    respond_with @record, location: @record.class
  end

  def compare
    @referencia =
      if params[:ref_id]
        VersionDecorator.find(params[:ref_id])
      else
        VersionDecorator.decorate @version.current
      end
  end

  def borradas
    @versiones = VersionDecorator.decorate VestalVersions::Version.where(tag: 'deleted', versioned_type: "Pagina").order("created_at DESC")
  end

private
  def find_version
    @version = VersionDecorator.decorate VestalVersions::Version.find(params[:version_id] || params[:id])
  end

  def reify_pagina
    @pagina = @version.reify
  end
end
