class AddBorradorToPagina < ActiveRecord::Migration
  def self.up
    add_column :paginas, :borrador, :boolean
  end

  def self.down
    remove_column :paginas, :borrador
  end
end
