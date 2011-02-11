# encoding: utf-8

module LayoutHelper
  def title(page_title, show_title = true)
    content_for(:title) { page_title.to_s }
    @show_title = show_title
  end

  def show_title?
    @show_title
  end

  def stylesheet(*args)
    asset :stylesheet, *args
  end

  alias_method :css, :stylesheet

  def javascript(*args)
    asset :javascript, *args
  end

  def stylesheets
    assets[:stylesheet]
  end

  def javascripts
    assets[:javascript]
  end

  def include_stylesheets
    stylesheets.map do |stylesheet|
      stylesheet_link_tag(stylesheet)
    end.join.html_safe
  end

  def include_javascripts
    javascripts.map do |javascript|
      javascript_include_tag(javascript)
    end.join.html_safe
  end

private
  def asset(type, *args)
    args.reject {|asset| assets[type].include?(asset) }.each do |asset|
      assets[type] = assets[type] << asset
    end
  end

  def assets
    @assets ||= Hash.new {[]} 
  end
end
