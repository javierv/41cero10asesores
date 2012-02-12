# encoding: utf-8

module LayoutHelper
  def title(variables = {})
    @title ||= I18n.translate! page_title_path, {resource: @resource}.merge(variables)
  end

  def show_title?
    @show_title = true if @show_title.nil?
  end

  def dont_show_title
    @show_title = false
  end

private
  def page_title_path
    "page_titles.#{params[:controller]}.#{params[:action]}"
  end
end
