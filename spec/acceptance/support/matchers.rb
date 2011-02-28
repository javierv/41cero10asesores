# encoding: utf-8

module MatcherMethods
  define_match :have_error do |actual, options = {}|
    actual.has_selector? "#flash_alert", options
  end

  define_match :have_success do |actual, options = {}|
    actual.has_selector? "#flash_notice", options
  end

  define_match :have_admin_navigation do |actual|
    actual.has_selector? "#admin"
  end

  define_match :have_autocomplete_list do |page, results|
    list = ".ui-autocomplete"
    page.has_selector?(list) &&
      page.has_selector?("#{list} li", count: results.count) &&
      results.inject(true) do |presentes, result|
        presentes && page.has_selector?("#{list} li", text: result)
      end
  end

  define_match :have_search_results do |page, results|
    resultados = "#resultados"
    page.has_selector?("#{resultados}") &&
      page.has_selector?("#{resultados} article", count: results.count) &&
      results.inject(true) do |presentes, result|
        presentes && page.has_selector?("#{resultados} article header", text: result)
      end
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
end

RSpec.configuration.include MatcherMethods, type: :acceptance
