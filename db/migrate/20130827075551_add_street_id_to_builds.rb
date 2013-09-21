class AddStreetIdToBuilds < ActiveRecord::Migration
  def change
  	add_column :builds, :street_id, :integer
  	add_index :builds, :street_id
  end
end
