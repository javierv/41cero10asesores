class Pagina < ActiveRecord::Base
  attr_accessible :titulo, :cuerpo, :caja_ids
  attr_writer :ids_cajas
  validates :titulo, :presence => true
  validates :cuerpo, :presence => true
  display_name :titulo

  has_many :sidebars
  has_many :cajas, :through => :sidebars
  before_save :build_sidebar

  def cajas_con_orden
    cajas.order("sidebars.orden ASC")
  end

  xapit :include => :cajas do |index|
    index.text :titulo, :weight => 10
    index.text :cuerpo, :weight => 4
    index.text :titulo_cajas, :weight => 3
    index.text :cuerpo_cajas, :weight => 1
  end

  def titulo_cajas
    cajas.map(&:titulo).join(' ')
  end

  def cuerpo_cajas
    cajas.map(&:cuerpo).join(' ')
  end

private
  def build_sidebar
    if @ids_cajas
      sidebars.destroy_all
      @ids_cajas.reject {|caja_id| caja_id.to_i.zero?}.each_with_index do |caja_id, index|
        sidebars.build(:caja_id => caja_id, :orden => index + 1)
      end
    end
  end
end