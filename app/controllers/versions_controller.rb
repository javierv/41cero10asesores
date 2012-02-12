# encoding: utf-8

class VersionsController < ApplicationController
  respond_to :html

  expose(:version) { VersionDecorator.find(params[:version_id] || params[:id]) }
  expose(:pagina) { PaginaDecorator.decorate version.reify }
  expose(:record) { version.restore! }
  expose(:pagina_referencia) { PaginaDecorator.decorate referencia.reify }

  expose(:versiones) { VersionDecorator.decorate VestalVersions::Version.where(tag: 'deleted', versioned_type: "Pagina").order("created_at DESC") }

  expose(:referencia) do
    if params[:ref_id]
      VersionDecorator.find(params[:ref_id])
    else
      VersionDecorator.decorate version.current
    end
  end

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
end
