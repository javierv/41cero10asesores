class DeviseCreateUsuarios < ActiveRecord::Migration
  def self.up
    create_table(:usuarios) do |t|
      t.database_authenticatable :null => false
      t.rememberable
      t.trackable

      t.timestamps
    end

    add_index :usuarios, :email, :unique => true
  end

  def self.down
    drop_table :usuarios
  end
end
