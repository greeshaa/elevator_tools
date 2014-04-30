class AddPorchIdToEquipment < ActiveRecord::Migration
  def change
    add_column :equipment, :porch_id, :integer
  end
end
