class CreateEquipmentMoveBuffers < ActiveRecord::Migration
  def change
    create_table :equipment_move_buffers do |t|
      t.integer :equipment_id

      t.timestamps
    end
  end
end
