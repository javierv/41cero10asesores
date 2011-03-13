class AddForeignIndex < ActiveRecord::Migration
  def self.up
    add_index :navegaciones,  :pagina_id
    add_index :paginas,       :published_id
    add_index :sidebars,      :pagina_id
    add_index :sidebars,      :caja_id
    add_index :slugs,         [:sluggable_id,  :sluggable_type]
  end

  def self.down
    remove_index :navegaciones,  :pagina_id
    remove_index :paginas,       :published_id
    remove_index :sidebars,      :pagina_id
    remove_index :sidebars,      :caja_id
    remove_index :slugs,         [:sluggable_id,  :sluggable_type]
  end
end
