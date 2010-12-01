# encoding: utf-8

class PaginasController < ApplicationController
  respond_to :html

  before_filter :find_pagina, :only => [:show, :edit, :update, :destroy, :historial]
  before_filter :new_pagina, :only => [:new, :create]
  before_filter :asignar_cajas, :only => [:create, :update]
  before_filter :preview, :only => [:create, :update]
  before_filter :save_draft, :only => [:create, :update]
  before_filter :publish_draft, :only => [:create, :update]

  def index
    @search = Pagina.metasearch params[:search]
    @paginas = @search.paginate :page => params[:page],
      :per_page => Pagina.per_page
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
    flash[:notice] = 'Pagina se borró correctamente.' if @pagina.destroy
    respond_with @pagina
  end

  def historial
    @versiones = @pagina.versions
  end

  def search
    @paginas = Pagina.search params[:q], :per_page => Pagina.per_page, :page => params[:page]
  end

private
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

  def preview
    if params[:preview]
      # HACK: asignar caja_ids guarda la relación en la BD. Ver:
      # https://rails.lighthouseapp.com/projects/8994/tickets/4521
      attributes = params[:pagina].clone
      attributes.delete(:caja_ids)
      @pagina.attributes = attributes

      # TODO: ¿Por qué no reconoce el formato JS en las peticiones AJAX que mando?
      # (Probé a incluir :js en el respond_to y daba igual)
      if request.xhr?
        render 'preview.js'
      else
        render 'preview'
      end
    end
  end

  def save_draft
    if params[:draft]
      flash[:notice] = 'Borrador guardado.' if @pagina.save_draft(params[:pagina])
      redirect_to edit_pagina_path(@pagina.draft)      
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
