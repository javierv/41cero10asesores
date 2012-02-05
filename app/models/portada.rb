# encoding: utf-8

class Portada < ActiveRecord::Base
  attr_accessible :pagina_id
  validates :pagina_id, presence: true
  belongs_to :pagina

  def self.portada
    first || new
  end
end
