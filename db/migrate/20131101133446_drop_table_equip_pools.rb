# -*- encoding : utf-8 -*-
class DropTableEquipPools < ActiveRecord::Migration

  def change
  	drop_table :equip_pools
  end
end
