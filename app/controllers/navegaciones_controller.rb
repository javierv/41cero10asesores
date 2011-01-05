class NavegacionesController < ApplicationController
  def new
    @ids = Navegacion.pagina_ids
  end

  def create
    Navegacion.establecer params[:navegacion][:pagina_id]
    redirect_to new_navegacion_path, :notice => 'Navegación guardada'
  end
end
