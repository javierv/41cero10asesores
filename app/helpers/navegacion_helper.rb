# encoding: utf-8

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
     ['Desconectar', destroy_usuario_session_path, {:class => 'desconectar'}]]
  end

  def actions_list(actions, resource)
    enlaces = actions.map do |action|
      if action.is_a?(Array)
        action
      else
        opciones = {:class => action}
        url = action_url(action, resource)
        if url.is_a?(Array)
          opciones.merge!(url.extract_options!)
        end
        [link_title(action), url, opciones].flatten
      end
    end
    lista_con_enlaces(enlaces, :class => 'actions')
  end

  def acciones_para_pagina(pagina)
    acciones = [:show, :edit, :destroy, :historial]
    if pagina.has_draft?
      acciones.push(['Editar borrador', edit_pagina_path(pagina.draft), {:class => 'draft'}])
    end
    actions_list(acciones, pagina)
  end

  def acciones_para_caja(caja)
    actions_list [:edit, :destroy], caja
  end
 
private
  def elemento_lista_enlace(enlace)
    opciones = enlace.extract_options!

    if opciones[:controller] == params[:controller]
      opciones[:class] = "#{opciones[:class]} current"      
    end

    if opciones[:controller]
      opciones[:class] = "#{opciones[:class]} #{opciones[:controller]}"
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
      when :index
        [resource.class, {:class => "index #{resource.class.to_s.tableize}"}]
      when :destroy
        [resource, {:method => :delete, :confirm => confirmation_message}]
      else
        polymorphic_path(resource, :action => action)
      end
  end
end
