class FotosController < ApplicationController
  respond_to :html
  before_filter :new_foto, :only => [:new, :create]

  def new
    respond_with @foto
  end

  def create
    if @foto.save
      flash[:notice] = 'Foto se creó correctamente.'
      opciones = {:location => new_foto_path}
    else
      opciones = {}
    end

    if request.xhr?
      render :json => {:name => @foto.imagen.name}
    else
      respond_with @foto, opciones
    end
  end

private
  def new_foto
    @foto = Foto.new(params[:foto])
  end
end
