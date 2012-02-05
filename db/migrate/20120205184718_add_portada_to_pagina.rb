class AddPortadaToPagina < ActiveRecord::Migration
  def change
    add_column :paginas, :portada, :boolean, default: false
  end
end
