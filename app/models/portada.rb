# encoding: utf-8

class Portada < ApplicationModel
  attr_accessible :pagina_id
  validates :pagina_id, presence: true
  belongs_to :pagina

  def self.portada
    first || new
  end
end
