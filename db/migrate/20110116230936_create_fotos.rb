class CreateFotos < ActiveRecord::Migration
  def self.up
    create_table :fotos do |t|
      t.string :imagen_uid

      t.timestamps
    end
  end

  def self.down
    drop_table :fotos
  end
end
