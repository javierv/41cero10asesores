class AddPublishedIdToPagina < ActiveRecord::Migration
  def self.up
    add_column :paginas, :published_id, :integer
  end

  def self.down
    remove_column :paginas, :published_id
  end
end
