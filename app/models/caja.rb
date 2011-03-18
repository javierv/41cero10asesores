# encoding: utf-8

class Caja < ActiveRecord::Base
  attr_accessible :titulo, :cuerpo, :pagina_ids
  validates :titulo, presence: true
  validates :cuerpo, presence: true
  display_name :titulo

  versioned dependent: :tracking, initial_version: true

  has_many :sidebars, dependent: :destroy
  has_many :paginas, through: :sidebars

  scope :por_titulo, order("cajas.titulo")

  scope :al_final_las_de_pagina, -> pagina {
    if pagina.new_record?
      por_titulo
    else
      joins("LEFT JOIN sidebars ON sidebars.caja_id=cajas.id AND pagina_id = #{pagina.id}").
      order("sidebars.orden, cajas.titulo")
    end
  }
end
