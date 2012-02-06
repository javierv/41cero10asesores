# encoding: utf-8

module LayoutHelper
  def title(page_title = @page_title, show_title = true)
    @show_title = show_title unless defined?(@show_title)
    @page_title = page_title
  end

  def show_title?
    @show_title
  end
end
