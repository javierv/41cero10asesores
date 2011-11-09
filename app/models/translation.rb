class Translation < Redis
  extend ActiveModel::Naming

  def to_key
    [1]
  end

  def public_keys
    keys(public_scope + "*").map do |key|
      [public_key(key), I18n.translate(key.sub("#{I18n.locale}.", ""))]
    end
  end

  def store_public_translations(translations, options = {})
    I18n.backend.store_translations I18n.locale, {public_prefix => translations},
      options
  end

  def method_missing(method, *args, &block)
    if public_value(method)
      public_value(method)
    else
      super
    end
  end

private
  def public_prefix
    :public
  end

  def public_scope
    "#{I18n.locale}.#{public_prefix}."
  end

  def public_key(full_key)
    full_key.sub public_scope, ""
  end

  def full_key(public_key)
    "#{public_scope}#{public_key}"
  end

  def public_value(public_key)
    self[full_key(public_key)]
  end
end
