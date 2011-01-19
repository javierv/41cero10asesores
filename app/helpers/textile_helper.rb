module TextileHelper
  def strict_textilize(texto)
   sanitize textilize(texto),
      :tags       => %w(a acronym strong em li ul ol blockquote br cite sub sup ins p img h2),
      :attributes => %w(href src alt class style)
  end
end