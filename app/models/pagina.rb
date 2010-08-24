class Pagina < ActiveRecord::Base
  attr_accessible :titulo, :cuerpo
  validates :titulo, :presence => true
  validates :cuerpo, :presence => true
  display_name :titulo

  has_many :sidebars
  has_many :cajas, :through => :sidebars
  before_save :build_sidebar

  def build_sidebar
    if @caja_ids
      sidebars.destroy_all
      @caja_ids.reject {|caja_id| caja_id.to_i.zero?}.each_with_index do |caja_id, index|
        sidebars.build(:caja_id => caja_id, :orden => index + 1)
      end
    end
  end

  def ids_cajas=(caja_ids)
    @caja_ids = caja_ids
  end
end