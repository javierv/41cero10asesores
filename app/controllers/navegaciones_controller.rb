# encoding: utf-8

class NavegacionesController < ApplicationController
  def new
  end

  def create
    Navegacion.establecer params[:navegacion][:pagina_id]
    redirect_to new_navegacion_path, notice: 'Navegación guardada'
  end

private
  def navegacion
    @navegacion ||= Navegacion.new
  end

  def paginas
    @paginas ||= PaginaDecorator.decorate Pagina.al_final_las_de_navegacion
  end

  def ids
    @ids ||= Navegacion.pagina_ids
  end

  helper_method :navegacion, :paginas, :ids
end
