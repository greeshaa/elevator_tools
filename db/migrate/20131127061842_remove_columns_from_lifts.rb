# -*- encoding : utf-8 -*-
class RemoveColumnsFromLifts < ActiveRecord::Migration
  def up
    remove_column :lifts, :build_id
    remove_column :lifts, :street_id
    remove_column :lifts, :manufacturer
    remove_column :lifts, :capacity
    remove_column :lifts, :owner
    remove_column :lifts, :contract
    remove_column :lifts, :lifttype
    remove_column :lifts, :end_of_service_at
  end

  def down
    add_column :lifts, :street_id, :integer
    add_column :lifts, :build_id, :integer
    add_column :lifts, :manufacturer, :string
    add_column :lifts, :capacity, :integer
    add_column :lifts, :owner, :string
    add_column :lifts, :contract, :string
    add_column :lifts, :lifttype, :string
    add_column :lifts, :end_of_service_at, :integer
  end
end
