module FiltradorHelper
  def filter_form_for(search, &block)    
    content_tag :section, :id => 'filtrador' do
      filter_form(search, &block) + reset_button(search)
    end
  end

private
  def filter_form(search, &block)
    simple_form_for search, :html => {:class => 'filtrador'} do |form|
      capture(form, &block) + form.submit('Filtrar')
    end
  end

  def reset_button(search)
    simple_form_for search, :html => {:id => 'reset_search', :class => 'reset'} do |form|
      hidden_field_tag(:reset, true) + form.submit('Ver todos', :id => 'reset_button')
    end
  end
end
