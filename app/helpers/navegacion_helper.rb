# encoding: utf-8

module NavegacionHelper
  def lista_con_enlaces(enlaces, opciones = {})
    return '' if enlaces.empty?
    content_tag :ul, opciones do
      elementos_lista_enlace(enlaces)
    end
  end

  def navegacion_admin    
    lista_con_enlaces(enlaces_admin << enlace_desconectar)
  end

  def navegacion_principal(paginas)
    lista_con_enlaces enlaces_navegacion(paginas)
  end

  def admin_actions_list(actions, resource)
    if usuario_signed_in?
      actions_list(actions, resource)
    end
  end

  def actions_list(actions, resource)
    lista_con_enlaces enlaces(actions, resource), class: 'actions'
  end

  def actions_cell(table, method)
    table.cell method, heading: "Acciones", cell_html: {class: "actions"}
  end

  def enlace_desconectar
     ["Desconectar", destroy_usuario_session_path,
       {class: "desconectar", method: :delete}]
  end

  def enlace_accion(action, resource)
    link_to *enlace(action, resource)
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

  def link_text(action, resource)
    I18n.translate(action,
                   scope:          "tabletastic.actions",
                   default:        action.to_s.titleize,
                   gender:         resource_name(resource).gender,
                   resource_name:  resource_name(resource).downcase)
  end

  def resource_name(resource)
    if resource.respond_to?(:model_name)
      resource.model_name.human
    else
      resource.class.model_name.human
    end
  end

  def link_title(action, resource)
    "#{link_text(action, resource)} #{resource}"
  end

  def enlaces(actions, resource)
    actions.map do |action|
      enlace(action, resource)
    end
  end

  def enlace(action, resource, opciones = {})
    if action.is_a?(Array)
      opciones.merge! action.extract_options!
      url = action[1] || action_url(action[0], resource)
      action = action[0]
    else
      url = action_url(action, resource)
    end

    if url.is_a?(Array)
      opciones.reverse_merge!(url.extract_options!)
    end
    opciones.reverse_merge!(class: action, title: link_title(action, resource))
    [link_text(action, resource), url, opciones].flatten
  end

  def action_url(action, resource)
    case action
      when :show
        resource
      when :index
        [resource.class, {class: "index #{resource.class.to_s.sub("Decorator", "").tableize}"}]
      when :destroy
        [resource, {method: :delete, remote: true}]
      else
        polymorphic_path(resource, action: action)
      end
  end
end
