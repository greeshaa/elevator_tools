# -*- encoding : utf-8 -*-
class AddUserIdToEquipmentMovements < ActiveRecord::Migration
  def change
    add_column :equipment_movements, :user_id, :integer
    remove_column :equipment_movements, :made_by
  end
end
