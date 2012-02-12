# encoding: utf-8

class NavegacionesController < ApplicationController
  before_filter :new_navegacion

  def new
    @ids = Navegacion.pagina_ids
    @paginas = PaginaDecorator.decorate Pagina.al_final_las_de_navegacion
  end

  def create
    Navegacion.establecer params[:navegacion][:pagina_id]
    redirect_to new_navegacion_path, notice: 'Navegación guardada'
  end

private
  def new_navegacion
    @navegacion = Navegacion.new
  end
end
