# encoding: utf-8

class ApplicationModel < ActiveRecord::Base
  self.abstract_class = true

  include Filter
  extend Paginate
end
