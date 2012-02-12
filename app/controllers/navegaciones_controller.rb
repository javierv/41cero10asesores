# encoding: utf-8

class NavegacionesController < ApplicationController
  expose(:navegacion) { Navegacion.new }
  expose(:paginas) { PaginaDecorator.decorate Pagina.al_final_las_de_navegacion }
  expose(:ids) { Navegacion.pagina_ids }

  def new
  end

  def create
    Navegacion.establecer params[:navegacion][:pagina_id]
    redirect_to new_navegacion_path, notice: 'Navegación guardada'
  end
end
