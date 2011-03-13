# encoding: utf-8

module SearchHelper
  def search_highlight(text, term)
    highlight text, search_split(term), highlighter: '<strong class="searched_term">\1</strong>'
  end

  def total_resultados(records)
    content_tag :p, class: "total_resultados" do
      if records.length.zero?
        "No hay resultados"
      else
        muestra_numero_resultados(records)
      end
    end
  end

private
  def search_split(term)
    term.scan(/"[^"]+"|\S+/).map { |word| word.delete('"') }
  end

  def muestra_numero_resultados(records)
    "Mostrando resultados ".html_safe +
      cantidad_tag(primero(records), class: "primero") + " a ".html_safe +
      cantidad_tag(ultimo(records), class: "ultimo") +  " de ".html_safe +
      cantidad_tag(records.total_count, class: "total")
  end

  def cantidad_tag(cantidad, options = {})
    content_tag :strong, cantidad, options
  end

  def ultimo(records)
    primero(records) + records.length - 1
  end

  def primero(records)
    (records.current_page - 1) * records.limit_value + 1
  end
end
