# -*- encoding : utf-8 -*-
class CreateIpAddresses < ActiveRecord::Migration
  def change
    create_table :ip_addresses do |t|
      t.string :name
      t.string :ip
      t.string :mask
      t.string :gate
      t.belongs_to :node
      t.belongs_to :provider

      t.timestamps
    end
  end
end
