# encoding: utf-8

module NavegacionHelper
  def lista_con_enlaces(enlaces, opciones = {})
    return '' if enlaces.empty?
    content_tag :ul, opciones do
      elementos_lista_enlace(enlaces)
    end
  end

  def navegacion_admin    
    lista_con_enlaces [
     ["Páginas", paginas_path, {controller: "paginas"}],
     ["Cajas", cajas_path, {controller: "cajas"}],
     ["Boletines", boletines_path, {controller: "boletines"}],
     ["Clientes", clientes_path, {controller: "clientes"}],
     ["Navegación", new_navegacion_path, {controller: "navegaciones"}],
     ["Desconectar", destroy_usuario_session_path, {class: "desconectar"}]]
  end

  def actions_list(actions, resource)
    lista_con_enlaces enlaces(actions, resource), class: 'actions'
  end

  def acciones_para_pagina(pagina)
    acciones = [:edit,
      enlace(:destroy, pagina, { method: :delete, remote: true, confirm: false }),
      :historial]

    if pagina.has_draft?
      acciones.push(['Editar borrador', edit_pagina_path(pagina.draft), {class: 'draft'}])
    end

    unless pagina.borrador?
      acciones.unshift :show
    end

    actions_list(acciones, pagina)
  end

  def acciones_para_caja(caja)
    actions_list [:edit, :destroy], caja
  end

  def acciones_para_version(version)
    actions = [:show]
    if version.previous
      actions << ['Anterior', 
                compare_vestal_versions_version_path(version, version.previous),
                {title: 'Comparar con la versión anterior a esta'}]
    end
    
    unless version.current?
      actions << ['Actual', compare_vestal_versions_version_path(version),
                  {title: 'Comparar con la versión actual'}]
    end
    actions_list actions, version
  end

  def acciones_para_boletin(boletin)
    acciones = [:edit]
    acciones << :enviar unless boletin.enviado?
    actions_list acciones, boletin
  end

  def acciones_para_cliente(cliente)
    actions_list [:edit], cliente
  end
 
private
  def elementos_lista_enlace(enlaces)
    enlaces.map do |enlace|
      elemento_lista_enlace(enlace)
    end.join.html_safe
  end

  def elemento_lista_enlace(enlace)
    opciones = opciones_para_enlace(enlace)
    
    content_tag :li do
      if opciones[:form]
        form_tag(enlace[1], method: opciones[:method]) do
          submit_tag(enlace[0])
        end
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

  def link_text(action)
    I18n.translate(action, scope: "tabletastic.actions", default: action.to_s.titleize)
  end

  def link_title(action, resource)
    "#{link_text(action)} #{resource}"
  end

  def confirmation_message
    I18n.t("tabletastic.actions.confirmation", default: "Are you sure?")
  end

  def enlaces(actions, resource)
    actions.map do |action|
      enlace(action, resource)
    end
  end

  def enlace(action, resource, opciones = {})
    if action.is_a?(Array)
      action
    else
      url = action_url(action, resource)
      if url.is_a?(Array)
        opciones.reverse_merge!(url.extract_options!)
      end
      opciones.reverse_merge!(class: action, title: link_title(action, resource))
      [link_text(action), url, opciones].flatten
    end
  end

  def action_url(action, resource)
    case action
      when :show
        resource
      when :index
        [resource.class, {class: "index #{resource.class.to_s.tableize}"}]
      when :destroy
        [resource, {method: :delete, confirm: confirmation_message}]
      else
        polymorphic_path(resource, action: action)
      end
  end
end
