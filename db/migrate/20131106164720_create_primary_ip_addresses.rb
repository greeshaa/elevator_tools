# -*- encoding : utf-8 -*-
class CreatePrimaryIpAddresses < ActiveRecord::Migration
  def change
    create_table :primary_ip_addresses do |t|
      t.string :ip
      t.string :mask
      t.string :gate
      t.belongs_to :provider
      t.belongs_to :node

      t.timestamps
    end
  end
end
