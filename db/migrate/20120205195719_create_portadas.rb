class CreatePortadas < ActiveRecord::Migration
  def change
    create_table :portadas do |t|
      t.integer :pagina_id

      t.timestamps
    end
  end
end
