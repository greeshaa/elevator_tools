class CreateEquipmentsGroups < ActiveRecord::Migration
  def change
    create_table :equipments_groups do |t|
      t.string :name

      t.timestamps
    end
  end
end
