# -*- encoding : utf-8 -*-
class AddColumnToInspections < ActiveRecord::Migration
  def change
    add_column :inspections, :next_inspection_at, :date
  end
end
