class RemoveNameFromManufacturers < ActiveRecord::Migration
  def up
    remove_column :manufacturers, :name
  end

  def down
    add_column :manufacturers, :name, :string
  end
end
