# -*- encoding : utf-8 -*-
class CreateEquipmentMovements < ActiveRecord::Migration
  def change
    create_table :equipment_movements do |t|
      t.belongs_to :destination
      t.belongs_to :equipment
      t.string :movement
      t.string :reason
      t.date :made_at
      t.integer :made_by

      t.timestamps
    end
  end
end
