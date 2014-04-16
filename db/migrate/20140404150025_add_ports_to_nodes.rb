# -*- encoding : utf-8 -*-
class AddPortsToNodes < ActiveRecord::Migration
  def change
    add_column :nodes, :dataport, :integer
    add_column :nodes, :soundport, :integer
  end
end
