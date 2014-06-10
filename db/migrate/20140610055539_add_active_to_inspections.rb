class AddActiveToInspections < ActiveRecord::Migration
  def change
    add_column :inspections, :active, :boolean, default: true
  end
end
