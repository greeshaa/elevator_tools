class CreateTlrs < ActiveRecord::Migration
  def change
    create_table :tlrs do |t|
      t.string :name

      t.timestamps
    end
  end
end
