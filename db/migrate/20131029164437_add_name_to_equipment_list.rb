# -*- encoding : utf-8 -*-
class AddNameToEquipmentList < ActiveRecord::Migration
  def change
    add_column :equipment_lists, :name, :string
  end
end
