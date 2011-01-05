class CreateNavegaciones < ActiveRecord::Migration
  def self.up
    create_table :navegaciones do |t|
      t.integer :pagina_id
      t.integer :orden

      t.timestamps
    end
  end

  def self.down
    drop_table :navegaciones
  end
end
