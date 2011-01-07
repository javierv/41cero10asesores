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

  def actions_list(actions, resource)
    enlaces = actions.map do |action|
      if action.respond_to?(:each)
        action
      else
        [link_title(action), action_url(action, resource)].flatten
      end
    end
    lista_con_enlaces(enlaces)
  end

  def acciones_para_pagina(pagina)
    acciones = [:show, :edit, :destroy, :historial]
    if pagina.has_draft?
      acciones.push(['Editar borrador', edit_pagina_path(pagina.draft)])
    end
    actions_list(acciones, pagina)
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

  def link_title(action)
    I18n.translate(action, :scope => "tabletastic.actions", :default => action.to_s.titleize)
  end

  def confirmation_message
    I18n.t("tabletastic.actions.confirmation", :default => "Are you sure?")
  end

  def action_url(action, resource)
    case action
      when :show
        resource
      when :destroy
        [resource, {:method => :delete, :confirm => confirmation_message}]
      else
        polymorphic_path(resource, :action => action)
      end
  end
end
