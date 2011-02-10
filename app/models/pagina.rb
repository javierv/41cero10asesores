# encoding: utf-8

class Pagina < ActiveRecord::Base
  attr_accessible :titulo, :cuerpo, :caja_ids, :updated_by
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

  versioned :dependent => :tracking, :initial_version => true

  def self.per_page
    15
  end

  def cajas_con_orden
    cajas.order("sidebars.orden ASC")
  end

  scope :al_final_las_de_navegacion, 
    includes(:navegacion).where("borrador = ? OR borrador IS NULL", false).
      order("navegaciones.orden, paginas.titulo")

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
      Pagina.find_by_id(attrs[:borrador_id]) || self
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
      copy_errors(pagina)
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
  
  def self.search_paginate(params)
    search = metasearch params[:search]
    paginas = search.where(:published_id => nil).paginate :page => params[:page],
      :per_page => per_page

    [search, paginas]
  end

  def self.siguiente(params)
    search, paginas = search_paginate(params)
    paginas.last unless paginas.count != per_page
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

  def copy_errors(pagina)
    pagina.errors.each do |field, message|
      errors.add(field, message)
    end
  end
end
