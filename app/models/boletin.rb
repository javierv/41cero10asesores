# encoding: utf-8

class Boletin < ActiveRecord::Base
  display_name :titulo
  image_accessor :archivo

  validates :titulo, presence: true
  validates :archivo, presence: true
  validates_property :mime_type, of: :archivo, in: %w(application/pdf),
    message: "Tiene que ser un PDF"
end
