module FiltradorHelper
  def filter_form_for(search, &block)
    search.instance_eval do
      def errors
        ActiveModel::Errors.new(self.base)
      end
    end
    content_tag :section, :id => 'filtrador' do
      filter_form(search, &block) + reset_button(search)
    end
  end

private
  # FIXME: ¡ya no sale el botón de buscar! ¡Ni el parámetro de reset! Hacer un test que lo verifique...
  def filter_form(search, &block)
    simple_form_for search do |form|
      block.call(form)
      form.submit 'Filtrar'
    end
  end

  def reset_button(search)
    simple_form_for search, :html => {:id => 'reset_search', :class => 'reset'} do |form|
      hidden_field_tag :reset, true
      form.submit 'Ver todos', :id => 'reset_button'
    end
  end
end