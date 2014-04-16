# -*- encoding : utf-8 -*-
class AddColumnsToLiftTypes < ActiveRecord::Migration
  def change
    add_column :lift_types, :model, :string
    add_column :lift_types, :elevation, :integer
    add_column :lift_types, :speed, :integer
  end
end
