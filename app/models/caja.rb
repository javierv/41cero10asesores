class Caja < ActiveRecord::Base
  attr_accessible :titulo, :cuerpo
  validates :titulo, :presence => true
  validates :cuerpo, :presence => true
  display_name :titulo

  has_many :sidebars
  scope :por_titulo, order("cajas.titulo")

  scope :al_final_las_de_pagina, lambda {|pagina|
    if pagina.new_record?
      por_titulo
    else
      joins("LEFT JOIN sidebars ON sidebars.caja_id=cajas.id AND pagina_id = #{pagina.id}").
      order("sidebars.orden, cajas.titulo")
    end
  }
end