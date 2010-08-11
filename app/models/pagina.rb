class Pagina < ActiveRecord::Base
  attr_accessible :titulo, :cuerpo
  validates :titulo, :presence => true
  validates :cuerpo, :presence => true
  display_name :titulo

  has_many :sidebars
  has_many :cajas, :through => :sidebars

  def build_sidebar(caja_ids)
    sidebars.destroy_all
    caja_ids.each_with_index do |caja_id, index|
      sidebars.build(:caja_id => caja_id, :orden => index + 1) unless caja_id.to_i.zero?
    end
  end
end