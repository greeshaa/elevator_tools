class CreateInspections < ActiveRecord::Migration
  def change
    create_table :inspections do |t|
      t.belongs_to :lift
      t.date :inspection_at

      t.timestamps
    end
  end
end
