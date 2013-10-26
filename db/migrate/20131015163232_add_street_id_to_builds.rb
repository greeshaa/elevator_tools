# -*- encoding : utf-8 -*-
class AddStreetIdToBuilds < ActiveRecord::Migration
  def change
  	add_column :builds, :street_id, :integer
  end
end
