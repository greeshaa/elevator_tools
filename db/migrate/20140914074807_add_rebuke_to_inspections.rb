class AddRebukeToInspections < ActiveRecord::Migration
  def change
    add_column :inspections, :rebuke, :boolean
    add_column :inspections, :comment, :string
  end
end
