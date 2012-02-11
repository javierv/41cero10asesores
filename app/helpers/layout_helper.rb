# encoding: utf-8

module LayoutHelper
  def title
    I18n.translate! page_title_path, {resource: @resource}
  end

private
  def page_title_path
    "page_titles.#{params[:controller]}.#{params[:action]}"
  end
end
