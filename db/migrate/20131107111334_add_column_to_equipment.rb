# -*- encoding : utf-8 -*-
class AddColumnToEquipment < ActiveRecord::Migration
  def change
    add_column :equipment, :node_id, :integer
    add_column :equipment, :lift_id, :integer
  end
end
