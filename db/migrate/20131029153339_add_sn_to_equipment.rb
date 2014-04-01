# -*- encoding : utf-8 -*-
class AddSnToEquipment < ActiveRecord::Migration
  def change
    add_column :equipment, :equipment_list_id, :integer
    add_column :equipment, :sn, :string
    add_column :equipment, :factory_sn, :string
    add_column :equipment, :installed_at, :date
    add_column :equipment, :varranty_till, :date
    add_column :equipment, :notes, :string
  end
end
