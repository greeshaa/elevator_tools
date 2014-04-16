# -*- encoding : utf-8 -*-
class RemoveSecondaryIpAddress < ActiveRecord::Migration
  def change
  	drop_table :secondary_ip_addresses
  end
end
