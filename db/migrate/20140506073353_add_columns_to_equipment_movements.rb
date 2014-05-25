# -*- encoding : utf-8 -*-
class AddColumnsToEquipmentMovements < ActiveRecord::Migration
  def change
    add_column :equipment_movements, :porch_id, :integer
    add_column :equipment_movements, :build_id, :integer
    add_column :equipment_movements, :street_id, :integer
    remove_column :equipment_movements, :destination_id, :integer
  end
end
