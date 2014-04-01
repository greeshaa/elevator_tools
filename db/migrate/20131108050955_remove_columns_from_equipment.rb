# -*- encoding : utf-8 -*-
class RemoveColumnsFromEquipment < ActiveRecord::Migration
  def up
    remove_column :equipment, :name
    remove_column :equipment, :sn
    remove_column :equipment, :varranty_till
  end

  def down
    add_column :equipment, :varranty_till, :date
    add_column :equipment, :sn, :string
    add_column :equipment, :name, :string
  end
end
