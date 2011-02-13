# encoding: utf-8

class Navegacion < ActiveRecord::Base
  attr_accessible :pagina_id, :orden
  validates :pagina_id, presence: true
  validates :orden, presence: true
  belongs_to :pagina
  display_name :pagina

  scope :por_orden, order(:orden)
  scope :con_paginas, includes(:pagina).por_orden

  def self.establecer(ids)
    delete_all

    ids.each_with_index.map do |id, orden|
      create(pagina_id: id, orden: orden + 1)
    end
  end

  def self.paginas
    con_paginas.map(&:pagina)
  end

  def self.pagina_ids
    por_orden.map(&:pagina_id)
  end
end
