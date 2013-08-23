# -*- encoding : utf-8 -*-
class CreateEquipmentsLogs < ActiveRecord::Migration
  def change
    create_table :equipments_logs do |t|
      t.string :equipmentlog
      t.string :description

      t.timestamps
    end
  end
end
