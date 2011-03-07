class AddDestinatariosToBoletin < ActiveRecord::Migration
  def self.up
    add_column :boletines, :destinatarios, :text
  end

  def self.down
    remove_column :boletines, :destinatarios
  end
end
