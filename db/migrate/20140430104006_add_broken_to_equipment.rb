# -*- encoding : utf-8 -*-
class AddBrokenToEquipment < ActiveRecord::Migration
  def change
    add_column :equipment, :broken, :boolean, default: false
    remove_column :equipment, :node_id
    remove_column :equipment, :destination_id
    remove_column :equipment, :lift_id
  end
end
