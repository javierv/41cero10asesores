# encoding: utf-8

class PaginasController < ApplicationController
  # Tengo que declarar antes el JS para que las peticiones AJAX respondan así.
  respond_to :js, only: [:index, :search, :destroy, :save_draft, :preview]
  respond_to :html

  public_actions :show, :search
  resource :pagina

  expose(:pagina) do
    # Código feo, pero mejor que poner @pagina en la acción show.
    if params[:action].to_sym == :show
      PaginaDecorator.decorate Pagina.where(borrador: false).find(params[:id])
    else
      find_or_new_pagina
    end
  end

  expose(:cajas) do
    if params[:action].to_sym == :preview
      CajaDecorator.decorate Caja.find_all_by_id(params[:pagina].clone.delete(:caja_ids) || [])
    else
      CajaDecorator.decorate Caja.al_final_las_de_pagina(pagina)
    end
  end

  expose(:paginas) do
    if params[:action].to_sym == :search
      PaginaDecorator.decorate resultados.map(&:indexed_object)
    else
      PaginaDecorator.decorate Pagina.paginated_records(params)
    end
  end

  expose(:fotos) { FotoDecorator.all }
  expose(:foto) { FotoDecorator.decorate Foto.new }
  expose(:versiones) { VersionDecorator.decorate pagina.versions.order("number DESC") }
  expose(:resultados) do
    Pagina.search params[:q], per_page: Pagina.default_per_page, page: params[:page]
  end
  expose(:filtracion) { Pagina.filtered_search params }

  before_filter :params_updated_by, only: [:create, :update, :save_draft, :publish]
  before_filter :asignar_cajas, only: [:create, :update, :save_draft]
  before_filter :destroy_pagina, only: :destroy

  def index
    respond_with paginas
  end

  def show
    respond_with pagina
  end

  def new
    respond_with pagina
  end

  def edit
    respond_with pagina
  end

  def create
    pagina.save
    respond_with pagina
  end

  def update
    pagina.update_attributes(params[:pagina])
    respond_with pagina
  end

  def save_draft
    pagina.save_draft(params[:pagina])
    respond_with pagina.draft, location: edit_pagina_path(pagina.draft)
  end

  def publish
    if pagina.publish params[:pagina]
      respond_with pagina.published
    else
      respond_with pagina
    end
  end

  def preview
    # HACK: asignar caja_ids guarda la relación en la BD. Ver:
    # https://github.com/rails/rails/issues/674
    # Además, no tenemos ningún test que indique que se asignan
    # las cajas de la forma esperada.
    pagina.attributes = params[:pagina].clone.tap {|attributes| attributes.delete(:caja_ids)}
    respond_with pagina
  end

  def destroy
    respond_with pagina
  end

  def historial
  end

  def search
    respond_with resultados
  end

private
  def params_updated_by
    params[:pagina][:updated_by] = current_usuario
  end

  def asignar_cajas
    if params[:pagina][:caja_ids]
      pagina.ids_cajas = params[:pagina][:caja_ids]
    end
  end
end
