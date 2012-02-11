# encoding: utf-8

class Pagina < ActiveRecord::Base
  attr_accessible :titulo, :cuerpo, :caja_ids, :updated_by
  attr_writer :ids_cajas

  with_options unless: :borrador? do |pagina|
    pagina.validates :titulo, presence: true
    pagina.validates :cuerpo, presence: true
  end

  display_name :titulo

  has_many :sidebars
  has_many :cajas, through: :sidebars
  has_one :navegacion, dependent: :destroy
  before_save :titulo_nil_si_blank
  before_save :build_sidebar
  before_save :set_borrador

  versioned dependent: :tracking, initial_version: true, unless: :borrador_con_pagina?
  has_friendly_id :titulo,
    allow_nil:                    true,
    use_slug:                     true,
    approximate_ascii:            true,
    ascii_approximation_options:  :spanish,
    reserved_words:               ["search"]

  XapianDb::DocumentBlueprint.setup(Pagina) do |blueprint|
    blueprint.attribute :titulo, weight: 10
    blueprint.attribute :cuerpo, weight: 4
    blueprint.index :titulo_cajas, weight: 3
    blueprint.index :cuerpo_cajas, weight: 1
    blueprint.ignore_if { borrador? }
  end

  def cajas_con_orden
    # TODO: Hack porque todavía no se pueden "decorar" automáticamente.
    CajaDecorator.decorate cajas.order("sidebars.orden ASC")
  end

  scope :al_final_las_de_navegacion, 
    includes(:navegacion).where("borrador = ? OR borrador IS NULL", false).
      order("navegaciones.orden, paginas.titulo")

  scope :por_orden, order(:titulo)
  scope :publicadas, where(published_id: nil)

  scope :paginate, -> page { publicadas.includes(:slug).page(page)}

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
    
    borrador = find_borrador attrs
    borrador.attributes = attributes.merge(attrs)
    borrador.borrador = true
    borrador.save
  end

  def draft
    return self if borrador?
    Pagina.where(published_id: id).first
  end

  def published
    Pagina.where(id: published_id).first || Pagina.new
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
      copy_errors(pagina)
      false
    end
  end

  def borrador_con_pagina?
    borrador? && !published.new_record? 
  end

private
  def build_sidebar
    if @ids_cajas
      sidebars.destroy_all
      @ids_cajas.reject {|caja_id| caja_id.to_i.zero?}.each.with_index do |caja_id, index|
        sidebars.build(caja_id: caja_id, orden: index + 1)
      end
    end
  end

  def find_borrador(attrs)
    if new_record?
      Pagina.find_by_id(attrs[:borrador_id]) || self
    else
      Pagina.find_or_create_by_published_id(id)
    end
  end

  def set_borrador
    self.borrador = false if borrador.nil?
    true
  end

  def copy_errors(pagina)
    unless pagina.errors == errors
      pagina.errors.each { |field, message| errors.add(field, message) }
    end
  end

  def titulo_nil_si_blank
    if titulo.blank?
      self.titulo = nil
    end
  end
end
