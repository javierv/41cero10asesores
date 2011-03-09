class AddEnviadoToBoletin < ActiveRecord::Migration
  def self.up
    add_column :boletines, :enviado, :boolean
  end

  def self.down
    remove_column :boletines, :enviado
  end
end
