# -*- encoding : utf-8 -*-
class CreateEquipmentLists < ActiveRecord::Migration
  def change
    create_table :equipment_lists do |t|
      t.belongs_to :equipment_type
      t.string :manufacturer
      t.string :description

      t.timestamps
    end
  end
end
