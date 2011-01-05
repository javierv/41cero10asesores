module NavegacionHelper
  def lista_con_enlaces(enlaces, opciones = {})
    return '' if enlaces.empty?
    content_tag :ul, opciones do
      enlaces.inject('') do |contenido, enlace|
        (contenido + elemento_lista_enlace(enlace)).html_safe
      end
    end
  end

  def navegacion_admin    
    lista_con_enlaces [['Editar páginas', paginas_path, {:controller => 'paginas'}],
     ['Editar cajas', cajas_path, {:controller => 'cajas'}],
     ['Editar navegación', new_navegacion_path, {:controller => 'navegaciones'}],
     ['Desconectar', destroy_usuario_session_path]]
  end
  
private
  def elemento_lista_enlace(enlace)
    opciones = enlace.extract_options!

    if opciones[:controller] == params[:controller]
      opciones[:class] = 'current'
      opciones.delete :controller
    end

    content_tag :li do
      link_to enlace[0], enlace[1], opciones
    end
  end
end
