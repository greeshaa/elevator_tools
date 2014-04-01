# -*- encoding : utf-8 -*-
class CreateElevatorControlStations < ActiveRecord::Migration
  def change
    create_table :elevator_control_stations do |t|
      t.string :name

      t.timestamps
    end
  end
end
