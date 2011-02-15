# encoding: utf-8

module LayoutHelper
  # Compatible with ryanb's
  # It doesn't mess up with content_for, but the code is quite ugly
  def title(page_title = @page_title, show_title = true)
    @show_title = show_title unless defined?(@show_title)
    @page_title = page_title
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
    include_assets :stylesheet do |stylesheet|
      stylesheet_link_tag(stylesheet)
    end
  end

  def include_javascripts
    include_assets :javascript do |javascript|
      javascript_include_tag(javascript)
    end
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

  def include_assets(type, &block)
    assets[type].map do |asset|
      block.call asset
    end.join.html_safe
  end
end
