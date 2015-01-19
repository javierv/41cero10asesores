# encoding: utf-8

module LayoutHelper
  def title(variables = {})
    @title ||= I18n.translate! page_title_path, {resource: get_record}.merge(variables)
  end

  def show_title?
    true unless @dont_show_title
  end

  def dont_show_title
    @dont_show_title = true
  end

private
  def page_title_path
    "page_titles.#{params[:controller]}.#{params[:action]}"
  end

  # Un poco hack...
  def get_record
    begin
      record
    rescue
      nil
    end
  end
end
