class Foto < ActiveRecord::Base
  image_accessor :imagen

  validates :imagen, :presence => true
  # validates_size_of :cover_image, :maximum => 500.kilobytes

  # validates_property :format, :of => :cover_image, :in => [:jpeg, :png, :gif]
  # ..or..
  # validates_property :mime_type, :of => :cover_image, :in => %w(image/jpeg image/png image/gif)

  # validates_property :width, :of => :cover_image, :in => (0..400), :message => "é demais cara!"
end