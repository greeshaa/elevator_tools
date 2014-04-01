# -*- encoding : utf-8 -*-
class AddColumnsToLifts < ActiveRecord::Migration
  def change
    add_column :lifts, :position, :string
    add_column :lifts, :lift_type_id, :integer
    add_column :lifts, :elevator_control_station_id, :integer
    add_column :lifts, :contract_id, :integer
    add_column :lifts, :mechanic_id, :integer
    add_column :lifts, :inspection_at, :date
  end
end
