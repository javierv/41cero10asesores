# encoding: utf-8

module SearchHelper
  def search_highlight(text, term)
    highlight text, term.split, highlighter: '<strong class="searched_term">\1</strong>'
  end
end
