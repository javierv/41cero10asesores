module Filter
  def self.included(base)
    base.extend(ClassMethods)
  end

  module ClassMethods
    def filter(name, term)
      helper = Helper.new
      metasearch(:"#{helper.search_field(name)}_all" => helper.values(term)).order(helper.field(name))
    end
  end

  def to_autocomplete(name)
    field = Helper.new.field(name)
    { id: id, label: send(field).truncate(50), value: send(field) }
  end

  class Helper
    def search_field(name)
      /\[(.*)\]/.match(name)[1]
    end

    def field(name)
      search_field(name).sub('_contains', '').to_sym
    end

    def values(term)
      term.split ' '
    end
  end
end
