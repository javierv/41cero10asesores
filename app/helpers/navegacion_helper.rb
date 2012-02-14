# encoding: utf-8

module NavegacionHelper
  def lista_con_enlaces(enlaces, opciones = {})
    return '' if enlaces.empty?
    content_tag :ul, opciones do
      elementos_lista_enlace(enlaces)
    end
  end

  def navegacion_admin    
    lista_con_enlaces(enlaces_admin)
  end

  def navegacion_principal(paginas)
    lista_con_enlaces enlaces_navegacion(paginas)
  end

  def actions_cell(table, method)
    table.cell method, heading: "Acciones", cell_html: {class: "actions"}
  end

private
  def enlaces_admin
    [
      ["Páginas", paginas_path],
      ["Cajas", cajas_path],
      ["Boletines", boletines_path],
      ["Clientes", clientes_path],
      ["Navegación", new_navegacion_path],
      ["Portada", new_portada_path],
      ["Textos", translations_path]
    ].map { |enlace| enlace << { controller: recognize_controller(enlace) }}
  end

  def recognize_controller(enlace)
    Rails.application.routes.recognize_path(enlace[1])[:controller]
  end

  def enlaces_navegacion(paginas)
    paginas.map do |pagina|
      enlace = [pagina.display_name, pagina_path(pagina)]

      # ¿Hay forma de conseguir esto sin usar variables de clase,
      # y que aun así funcione para URLs obsoletas?
      if pagina == @pagina
        enlace << {class: "current"}
      else
        enlace
      end
    end
  end

  def elementos_lista_enlace(enlaces)
    enlaces.map do |enlace|
      elemento_lista_enlace(enlace)
    end.join.html_safe
  end

  def elemento_lista_enlace(enlace)
    opciones = opciones_para_enlace(enlace)
    
    content_tag :li do
      if opciones[:form]
        opciones.delete(:form)
        button_to enlace[0], enlace[1], opciones
      else
        link_to enlace[0], enlace[1], opciones
      end
    end
  end

  def opciones_para_enlace(enlace)
    opciones = enlace.extract_options!

    if opciones[:controller]
      opciones[:class] = "#{opciones[:class]} #{clase opciones[:controller]}"
      opciones.delete :controller
    end

    opciones
  end

  def clase(controller)
    if controller == params[:controller]
      "#{controller} current"
    else
      controller
    end
  end
end
