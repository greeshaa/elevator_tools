class CreateEquipmentLineItems < ActiveRecord::Migration
  def change
    create_table :equipment_line_items do |t|
      t.integer :equipment_id
      t.integer :equipment_move_buffer_id

      t.timestamps
    end
  end
end
