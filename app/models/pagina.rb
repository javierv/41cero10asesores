class Pagina < ActiveRecord::Base
  attr_accessible :titulo, :cuerpo, :caja_ids
  attr_writer :ids_cajas

  with_options :unless => :borrador? do |pagina|
    pagina.validates :titulo, :presence => true
    pagina.validates :cuerpo, :presence => true
  end

  display_name :titulo

  has_many :sidebars
  has_many :cajas, :through => :sidebars
  has_one :navegacion, :dependent => :destroy
  before_save :build_sidebar
  before_save :set_borrador

  has_paper_trail

  def cajas_con_orden
    cajas.order("sidebars.orden ASC")
  end

  scope :al_final_las_de_navegacion, 
    includes(:navegacion).where("borrador = ? OR borrador IS NULL", false).
      order("navegaciones.orden, paginas.titulo")

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
    !borrador? && draft != nil
  end

  def save_draft(attrs = {})
    return update_attributes(attrs) if borrador?
    
    borrador = if new_record?
      self
    else
      Pagina.find_or_create_by_published_id(id)
    end
    
    borrador.attributes = attributes.merge(attrs)
    borrador.borrador = true
    borrador.published_id = id
    borrador.save
  end

  def draft
    return self if borrador?
    Pagina.where(:published_id => id).first
  end

  def published
    Pagina.where(:id => published_id).first || Pagina.new
  end

  def publish(attrs = {})
    return save unless borrador?

    pagina = published
    pagina.attributes = attributes.merge(attrs)
    pagina.borrador = false

    if pagina.save
      self.published_id = pagina.id
      destroy
    else
      pagina.errors.each do |field, message|
        errors.add(field, message)
      end

      false
    end
  end

  def tipo
    if borrador?
      'Borrador'
    else
      'Publicada'
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

  def set_borrador
    self.borrador = false if borrador.nil?
    true
  end
end