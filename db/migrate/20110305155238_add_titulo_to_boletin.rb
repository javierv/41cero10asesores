class AddTituloToBoletin < ActiveRecord::Migration
  def self.up
    add_column :boletines, :titulo, :string
  end

  def self.down
    remove_column :boletines, :titulo
  end
end
