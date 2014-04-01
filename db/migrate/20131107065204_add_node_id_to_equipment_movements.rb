# -*- encoding : utf-8 -*-
class AddNodeIdToEquipmentMovements < ActiveRecord::Migration
  def change
    add_column :equipment_movements, :node_id, :integer
  end
end
