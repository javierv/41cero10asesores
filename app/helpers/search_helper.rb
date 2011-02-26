# encoding: utf-8

module SearchHelper
  def search_highlight(text, term)
    highlight text, search_split(term), highlighter: '<strong class="searched_term">\1</strong>'
  end

private
  def search_split(term)
    term.scan(/"[^"]+"|\S+/).map { |word| word.delete('"') }
  end
end
