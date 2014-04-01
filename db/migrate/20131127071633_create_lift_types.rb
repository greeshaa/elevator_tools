# -*- encoding : utf-8 -*-
class CreateLiftTypes < ActiveRecord::Migration
  def change
    create_table :lift_types do |t|
      t.belongs_to :manufacturer
      t.integer :capacity
      t.string :function
      t.string :doors

      t.timestamps
    end
  end
end
