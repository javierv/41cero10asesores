class AddImagenToCaja < ActiveRecord::Migration
  def change
    add_column :cajas, :imagen_uid, :string
    add_column :cajas, :imagen_name, :string
  end
end
