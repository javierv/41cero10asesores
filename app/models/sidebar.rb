class Sidebar < ActiveRecord::Base
  attr_accessible :pagina_id, :caja_id, :orden
  validates :pagina_id, :presence => true
  validates :caja_id, :presence => true
  validates :orden, :presence => true

  belongs_to :caja
  belongs_to :pagina
end