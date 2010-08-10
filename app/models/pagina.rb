class Pagina < ActiveRecord::Base
  attr_accessible :titulo, :cuerpo
  validates :titulo, :presence => true
  validates :cuerpo, :presence => true
  display_name :titulo
end