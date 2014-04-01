# -*- encoding : utf-8 -*-
class DropTableEquipLog < ActiveRecord::Migration
  def change
  	drop_table :equip_logs
  end
end
