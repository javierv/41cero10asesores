class CreateBoletines < ActiveRecord::Migration
  def self.up
    create_table :boletines do |t|
      t.string :archivo_uid

      t.timestamps
    end
  end

  def self.down
    drop_table :boletines
  end
end
