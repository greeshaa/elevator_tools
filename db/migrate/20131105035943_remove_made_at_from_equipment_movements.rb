# -*- encoding : utf-8 -*-
class RemoveMadeAtFromEquipmentMovements < ActiveRecord::Migration
  def up
    remove_column :equipment_movements, :made_at
  end

  def down
    add_column :equipment_movements, :made_at, :date
  end
end
