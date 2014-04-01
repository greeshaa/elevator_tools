# -*- encoding : utf-8 -*-
class AddDestinationIdToEquipment < ActiveRecord::Migration
  def change
    add_column :equipment, :destination_id, :integer
  end
end
