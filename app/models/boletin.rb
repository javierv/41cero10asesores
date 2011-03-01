# encoding: utf-8

class Boletin < ActiveRecord::Base
  image_accessor :archivo

  validates :archivo, presence: true
  validates_property :mime_type, of: :archivo, in: %w(application/pdf),
    message: "Tiene que ser un PDF"
  display_name :archivo_uid
end
