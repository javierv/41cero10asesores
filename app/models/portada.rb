# encoding: utf-8

class Portada < ActiveRecord::Base
  attr_accessible :pagina_id
  validates :pagina_id, presence: true
  belongs_to :pagina

  def self.pagina
    first.pagina
  end

  def self.asigna(pagina)
    delete_all
    create(pagina_id: pagina.id)
  end
end
