class CreateDowntimes < ActiveRecord::Migration
  def change
    create_table :downtimes do |t|
      t.integer :lift_id
      t.date :dt_date
      t.string :reason

      t.timestamps
    end
  end
end
