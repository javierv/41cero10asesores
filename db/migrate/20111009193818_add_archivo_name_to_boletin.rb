class AddArchivoNameToBoletin < ActiveRecord::Migration
  def change
    add_column :boletines, :archivo_name, :string
  end
end
