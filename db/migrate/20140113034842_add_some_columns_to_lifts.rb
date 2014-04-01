class AddSomeColumnsToLifts < ActiveRecord::Migration
  def change
    add_column :lifts, :manufacturer, :string
    add_column :lifts, :model, :string
    add_column :lifts, :function, :string
    add_column :lifts, :doors, :string
    add_column :lifts, :capacity, :integer
    add_column :lifts, :speed, :integer
    add_column :lifts, :elevation, :integer
  end
end
