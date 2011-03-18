# encoding: utf-8

module MatcherMethods
  define_match :have_title do |page, options = {}|
    page.has_selector? "title", options
  end

  define_match :have_error do |actual, options = {}|
    actual.has_selector? "#flash_alert", options
  end

  define_match :have_success do |actual, options = {}|
    actual.has_selector? "#flash_notice", options
  end

  define_match :have_admin_navigation do |actual|
    actual.has_selector? "#admin"
  end

  define_match :have_pages_list do |page, results|
    table = "tbody"
    page.has_results? table, "#{table} tr", "#{table} td", results
  end

  define_match :have_autocomplete_list do |page, results|
    list = ".ui-autocomplete"
    page.has_results? list, "#{list} li", "#{list} li", results
  end

  define_match :have_search_results do |page, results|
    resultados = "#resultados"
    page.has_results? resultados, "#{resultados} article",
                     "#{resultados} article header", results
  end

  define_match :have_clientes_seleccionados do |page, results|
    clientes = "#clientes"
    page.has_results? clientes, "#{clientes} input", "#{clientes} label", results
  end

  define_match :have_search_suggestion do |page, suggestion|
    page.has_selector?("#sugerencia", text: suggestion)
  end

  define_match :have_pagination do |page|
    page.has_selector?(".pagination")
  end

  define_match :have_highlight do |page, text|
    page.has_selector?("strong.searched_term", text: text)
  end

  define_match :have_fotos do |page, options|
    page.has_selector?("#galeria img", options)
  end
end

module Capybara::Node::Matchers
  def has_results?(container, subcontainer, element, results)
    has_selector?("#{container}") &&
      has_selector?("#{subcontainer}", count: results.count) &&
      results.inject(true) do |presentes, result|
        presentes && has_selector?("#{element}", text: result)
      end
  end
end
RSpec.configuration.include MatcherMethods, type: :request
