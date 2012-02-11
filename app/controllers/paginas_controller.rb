# encoding: utf-8

class PaginasController < ApplicationController
  # Tengo que declarar antes el JS para que las peticiones AJAX respondan así.
  respond_to :js, only: [:index, :search, :destroy, :save_draft, :preview]
  respond_to :html

  public_actions :show, :search
  resource :pagina

  before_filter :params_updated_by, only: [:create, :update, :save_draft, :publish]
  before_filter :find_pagina, only: [:edit, :update, :destroy, :historial, :publish]
  before_filter :new_pagina, only: [:new, :create]
  before_filter :find_or_new_pagina, only: [:preview, :save_draft]
  before_filter :asignar_cajas, only: [:create, :update, :save_draft]
  before_filter :paginate_paginas, only: :index

  def index
    @paginas = PaginaDecorator.decorate @paginas
    respond_with @paginas    
  end

  def show
    @pagina = Pagina.where(borrador: false).find(params[:id])
    respond_with @pagina
  end

  def new
    respond_with @pagina
  end

  def edit
    respond_with @pagina
  end

  def create
    @pagina.save
    respond_with @pagina
  end

  def update
    @pagina.update_attributes(params[:pagina])
    respond_with @pagina
  end

  def save_draft
    @pagina.save_draft(params[:pagina])
    respond_with @pagina.draft, location: edit_pagina_path(@pagina.draft)
  end

  def publish
    if @pagina.publish params[:pagina]
      respond_with @pagina.published
    else
      respond_with @pagina
    end
  end

  def preview
    # HACK: asignar caja_ids guarda la relación en la BD. Ver:
    # https://github.com/rails/rails/issues/674
    attributes = params[:pagina].clone
    @cajas = CajaDecorator.decorate Caja.find_all_by_id(attributes.delete(:caja_ids) || [])
    @pagina.attributes = attributes
    respond_with @pagina
  end

  def destroy
    if @pagina.destroy
      @deshacer = deshacer_borrado_path(@pagina)
      @siguiente = next_pagina if request.xhr?
    end
    respond_with @pagina
  end

  def historial
    @versiones = @pagina.versions.order("number DESC")
  end

  def search
    @paginas = Pagina.search params[:q], per_page: Pagina.default_per_page, page: params[:page]
    respond_with @paginas
  end

private
  def params_updated_by
    params[:pagina][:updated_by] = current_usuario
  end

  def asignar_cajas
    if params[:pagina][:caja_ids]
      @pagina.ids_cajas = params[:pagina][:caja_ids]
    end
  end

  def find_or_new_pagina
    if params[:id]
      find_pagina
    else
      new_pagina
    end
  end

  def find_pagina
    @pagina = PaginaDecorator.find params[:id]
  end
end
