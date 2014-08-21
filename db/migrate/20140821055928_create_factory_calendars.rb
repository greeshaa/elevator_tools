class CreateFactoryCalendars < ActiveRecord::Migration
  def change
    create_table :factory_calendars do |t|
      t.integer :month
      t.string :month_name
      t.integer :cal_days
      t.integer :work_days

      t.timestamps
    end
  end
end
