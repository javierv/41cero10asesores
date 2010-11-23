module NavegacionHelper
  def lista_con_enlaces(enlaces, opciones = {})
    return '' if enlaces.empty?
    content_tag :ul, opciones do
      enlaces.inject('') do |contenido, enlace|
        (contenido + elemento_lista_enlace(enlace)).html_safe
      end
    end
  end
  
private
  def elemento_lista_enlace(enlace)
    opciones = enlace.extract_options!
    content_tag :li do
      link_to enlace[0], enlace[1], opciones
    end
  end
end
