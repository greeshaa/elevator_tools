class RemovePrimaryIpAddress < ActiveRecord::Migration
  def change
  	drop_table :primary_ip_addresses
  end
end
