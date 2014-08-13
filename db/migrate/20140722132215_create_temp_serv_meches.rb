# -*- encoding : utf-8 -*-
class CreateTempServMeches < ActiveRecord::Migration
  def change
    create_table :temp_serv_meches do |t|
      t.integer :lift_id
      t.integer :mechanic_id
      t.date :start_at
      t.date :end_at

      t.timestamps
    end
  end
end
