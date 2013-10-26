# -*- encoding : utf-8 -*-
class CreateLifts < ActiveRecord::Migration
  def change
    create_table :lifts do |t|
      t.belongs_to :node
      t.belongs_to :porch
      t.belongs_to :build
      t.belongs_to :street

      t.string :regnum
      t.string :sernum
      t.string :manufacturer
      t.string :type
      t.integer :capacity
      t.integer :stopscount
      t.string :owner
      t.string :contract
      t.integer :introduced_at
      t.integer :overhaul_at
      t.integer :standart_life
      t.integer :end_of_service_at

      t.timestamps
    end
  end
end
