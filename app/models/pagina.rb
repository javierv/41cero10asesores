class Pagina < ActiveRecord::Base
  attr_accessible :titulo, :cuerpo, :caja_ids
  attr_writer :ids_cajas
  validates :titulo, :presence => true
  validates :cuerpo, :presence => true
  display_name :titulo

  has_many :sidebars
  has_many :cajas, :through => :sidebars
  before_save :build_sidebar

  has_paper_trail

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

  def has_draft?
    draft != nil
  end

  def save_draft
    borrador = Pagina.find_or_create_by_published_id(id)
    borrador.attributes = attributes
    borrador.borrador = true
    borrador.published_id = id
    borrador.save
  end

  def draft
    Pagina.where(:published_id => id).first
  end

  def publish
    return save unless borrador?

    begin
      pagina = Pagina.find published_id
    rescue ActiveRecord::RecordNotFound
      pagina = Pagina.new
    end

    pagina.attributes = attributes

    if pagina.save
      destroy
    end
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