class AddImagenWidthToFoto < ActiveRecord::Migration
  def self.up
    add_column :fotos, :imagen_width, :integer
  end

  def self.down
    remove_column :fotos, :imagen_width
  end
end
