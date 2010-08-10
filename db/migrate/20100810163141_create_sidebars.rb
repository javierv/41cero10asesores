class CreateSidebars < ActiveRecord::Migration
  def self.up
    create_table :sidebars do |t|
      t.integer :pagina_id
      t.integer :caja_id
      t.integer :orden

      t.timestamps
    end
  end

  def self.down
    drop_table :sidebars
  end
end
