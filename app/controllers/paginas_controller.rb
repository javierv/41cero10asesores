# encoding: utf-8

class PaginasController < ApplicationController
  # Tengo que declarar antes el JS para que las peticiones AJAX respondan así.
  respond_to :js, only: [:index, :search, :destroy]
  respond_to :html

  public_actions :show, :search
  resource :pagina

  before_filter :params_updated_by, only: [:create, :update]
  before_filter :find_pagina, only: [:edit, :update, :destroy, :historial]
  before_filter :new_pagina, only: [:new, :create]
  before_filter :asignar_cajas, only: [:create, :update]
  before_filter :preview, only: [:create, :update]
  before_filter :save_draft, only: [:create, :update]
  before_filter :publish_draft, only: [:create, :update]
  before_filter :paginate_paginas, only: :index

  def index
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

  def destroy
    if @pagina.destroy
      if @pagina.versions.last
        @deshacer = restore_vestal_versions_version_path(@pagina.versions.last)
      end
    end
    if request.xhr?
      @siguiente = next_pagina
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

  # TODO: pasar a acción independiente en cuanto funcione "formaction".
  def preview
    if params[:preview]
      # HACK: asignar caja_ids guarda la relación en la BD. Ver:
      # https://rails.lighthouseapp.com/projects/8994/tickets/4521
      attributes = params[:pagina].clone
      @cajas = Caja.find_all_by_id(attributes.delete(:caja_ids) || [])
      @pagina.attributes = attributes
      if request.xhr?
        render 'preview.js'
      else
        render 'preview'
      end
    end
  end

  def save_draft
    if params[:draft]
      if request.xhr?
        @pagina.save_draft(params[:pagina])
        render 'borrador.js'
      else
        flash[:notice] = 'Borrador guardado.' if @pagina.save_draft(params[:pagina])
        redirect_to edit_pagina_path(@pagina.draft)
      end
    end
  end

  def publish_draft
    if params[:publish]
      if @pagina.publish(params[:pagina])
        flash[:notice] = 'Borrador publicado.'
        redirect_to(pagina_path(@pagina.published))
      else
        render 'edit'
      end
    end
  end
end
