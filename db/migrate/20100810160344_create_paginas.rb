class CreatePaginas < ActiveRecord::Migration
  def self.up
    create_table :paginas do |t|
      t.string :titulo
      t.text :cuerpo

      t.timestamps
    end
  end

  def self.down
    drop_table :paginas
  end
end
