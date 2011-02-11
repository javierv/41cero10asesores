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
    asset :stylesheet, *args do |stylesheet|
      content_for(:head) { stylesheet_link_tag(stylesheet) }
    end
  end

  alias_method :css, :stylesheet

  def javascript(*args)
    asset :javascript, *args do |javascript|
      content_for(:head) { javascript_include_tag(javascript) }
    end
  end

  def stylesheets
    assets[:stylesheet]
  end

  def javascripts
    assets[:javascript]
  end

private
  def asset(type, *args, &block)
    args.reject {|asset| assets[type].include?(asset) }.each do |asset|
      block.call asset
      assets[type] = assets[type] << asset
    end
  end

  def assets
    @assets ||= Hash.new {[]} 
  end
end
