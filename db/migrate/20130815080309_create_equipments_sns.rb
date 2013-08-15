class CreateEquipmentsSns < ActiveRecord::Migration
  def change
    create_table :equipments_sns do |t|
      t.string :serialnumber
      t.string :description

      t.timestamps
    end
  end
end
