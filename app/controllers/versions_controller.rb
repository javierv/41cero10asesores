# encoding: utf-8

class VersionsController < ApplicationController
  respond_to :html

  def show
  end

  def recover
    pagina.save
    respond_with pagina
  end

  def restore
    record = version.restore!
    respond_with record, location: record.class
  end

  def compare

  end

  def borradas
  end

private
  def version
    @version ||= VersionDecorator.find(params[:version_id] || params[:id])
  end

  def pagina
    @pagina ||= PaginaDecorator.decorate version.reify
  end

  def record
    @record ||= version.restore!
  end

  def referencia
    @referencia ||=
      if params[:ref_id]
        VersionDecorator.find(params[:ref_id])
      else
        VersionDecorator.decorate version.current
      end
  end

  def pagina_referencia
    @pagina_referencia ||= PaginaDecorator.decorate referencia.reify
  end

  def versiones
    @versiones ||= VersionDecorator.decorate VestalVersions::Version.where(tag: 'deleted', versioned_type: "Pagina").order("created_at DESC")
  end

  helper_method :version, :pagina, :record, :referencia, :pagina_referencia, :versiones
end
