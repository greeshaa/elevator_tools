# -*- encoding : utf-8 -*-
class AddNewColumnsToLifts < ActiveRecord::Migration
  def change
    add_column :lifts, :made_at, :date
    add_column :lifts, :manufacturer_id, :integer
  end
end
