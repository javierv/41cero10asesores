# encoding: utf-8

class PaginasController < ApplicationController
  # Tengo que declarar antes el JS para que las peticiones AJAX respondan así.
  respond_to :js, :only => [:index]
  respond_to :html

  before_filter :params_updated_by, :only => [:create, :update]
  before_filter :find_pagina, :only => [:show, :edit, :update, :destroy, :historial]
  before_filter :new_pagina, :only => [:new, :create]
  before_filter :asignar_cajas, :only => [:create, :update]
  before_filter :preview, :only => [:create, :update]
  before_filter :save_draft, :only => [:create, :update]
  before_filter :publish_draft, :only => [:create, :update]

  def index
    @search, @paginas = Pagina.search_paginate(params)
    respond_with @paginas    
  end

  def show
    respond_with @pagina
  end

  def new
    respond_with @pagina
  end

  def edit
    respond_with @pagina
  end

  def create
    flash[:notice] = 'Pagina se creó correctamente.' if @pagina.save
    respond_with @pagina
  end

  def update
    flash[:notice] = 'Pagina se actualizó correctamente.' if @pagina.update_attributes(params[:pagina])
    respond_with @pagina
  end

  def destroy
    if @pagina.destroy
      flash[:notice] = 'Pagina se borró correctamente.'
      if @pagina.versions.last
        session[:deshacer] = { 
          :method => :put,
          :url    => restore_vestal_versions_version_path(@pagina.versions.last)
        }
      end
    end
    if request.xhr?
      @siguiente = Pagina.siguiente(session_params(:index) || {})
    else
      respond_with @pagina
    end
  end

  def historial
    @versiones = @pagina.versions.order("number DESC")
  end

  def search
    @paginas = Pagina.search params[:q], :per_page => Pagina.per_page, :page => params[:page]
  end

private
  def public_actions
    [:show, :search]
  end

  def params_updated_by
    params[:pagina][:updated_by] = current_usuario
  end

  def find_pagina
    @pagina = Pagina.find(params[:id])
  end

  def new_pagina
    @pagina = Pagina.new(params[:pagina])
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
      attributes.delete(:caja_ids)
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
