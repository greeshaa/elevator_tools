# -*- encoding : utf-8 -*-
class RemoveModelFromEquipmentList < ActiveRecord::Migration
  def up
    remove_column :equipment_lists, :model
  end

  def down
    add_column :equipment_lists, :model, :string
  end
end
