class Pagina < ActiveRecord::Base
  attr_accessible :titulo, :cuerpo
  validates :titulo, :presence => true
  validates :cuerpo, :presence => true
  display_name :titulo

  has_many :sidebars
  has_many :cajas, :through => :sidebars
end