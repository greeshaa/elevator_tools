# -*- encoding : utf-8 -*-
class CreateEquipmentTypes < ActiveRecord::Migration
  def change
    create_table :equipment_types do |t|
      t.string :name
      t.string :description

      t.timestamps
    end
  end
end
