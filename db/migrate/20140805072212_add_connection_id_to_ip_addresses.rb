# -*- encoding : utf-8 -*-
class AddConnectionIdToIpAddresses < ActiveRecord::Migration
  def change
    add_column :ip_addresses, :connection_id, :integer
  end
end
