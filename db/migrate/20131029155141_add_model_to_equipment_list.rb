# -*- encoding : utf-8 -*-
class AddModelToEquipmentList < ActiveRecord::Migration
  def change
    add_column :equipment_lists, :model, :string
  end
end
