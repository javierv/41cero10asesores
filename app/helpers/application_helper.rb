# encoding: utf-8

module ApplicationHelper
  def edit_pagina_title(pagina)
    if pagina.borrador?
      "Editando borrador de #{pagina}"
    else
      "Editando la página #{pagina}"
    end
  end

  def save_draft_path(pagina)
    if pagina.new_record?
      save_draft_paginas_path
    else
      save_draft_pagina_path(pagina)
    end
  end

  def preview_path(pagina)
    if pagina.new_record?
      preview_paginas_path
    else
      preview_pagina_path(pagina)
    end
  end

  def time_tag(date_or_time, *args)
    options  = args.extract_options!
    content  = args.first || I18n.l(date_or_time, format: :long)
    datetime = date_or_time.acts_like?(:time) ? date_or_time.xmlschema : date_or_time.rfc3339
    content_tag :time, content, options.reverse_merge(datetime: datetime)
  end
end
