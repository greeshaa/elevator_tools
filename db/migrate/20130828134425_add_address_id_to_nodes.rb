# -*- encoding : utf-8 -*-
class AddAddressIdToNodes < ActiveRecord::Migration
  def change
  	add_column :nodes, :street_id, :integer
  	add_column :nodes, :build_id, :integer
  end
end
