class CreateTimeSheets < ActiveRecord::Migration
  def change
    create_table :time_sheets do |t|
      t.integer :time_sheet_kind_id
      t.integer :mechanic_id
      t.datetime :start_at
      t.datetime :end_at

      t.timestamps
    end
  end
end
