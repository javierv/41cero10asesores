# encoding: utf-8

class Sidebar < ApplicationModel
  attr_accessible :pagina_id, :caja_id, :orden
  validates :pagina_id, presence: true
  validates :caja_id, presence: true

  belongs_to :caja
  belongs_to :pagina
end
