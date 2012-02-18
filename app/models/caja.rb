# encoding: utf-8

class Caja < ApplicationModel
  attr_accessible :titulo, :cuerpo, :pagina_ids, :imagen, :remove_imagen, :retained_imagen
  validates :titulo, presence: true

  image_accessor :imagen
  validates_property :mime_type, of: :imagen, in: %w(image/jpeg image/png image/gif),
    message: "Se admiten formatos PNG, GIF y JPEG"

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

  def imagen?
    imagen != nil
  end
end
