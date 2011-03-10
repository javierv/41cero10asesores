# encoding: utf-8

module Gender
  def self.included(base)
    base.extend(ClassMethods)
  end

  def gender
    if self.class.irregular_genders.keys.include?(self)
      self.class.irregular_genders[self]
    elsif last == "a"
      :female
    else
      :male
    end
  end

  module ClassMethods
    def add_irregular_gender(word, gender = nil)
      hash = if gender.nil?
               word
             else
               {word => gender}
             end
      irregular_genders.merge!(hash)
    end

    def irregular_genders
      @irregular_genders ||= {}
    end
  end
end

String.send :include, Gender
