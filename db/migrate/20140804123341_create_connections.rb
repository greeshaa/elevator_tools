class CreateConnections < ActiveRecord::Migration
  def change
    create_table :connections do |t|
    	t.string  :title
      t.integer :porch_id
      t.integer :provider_id


      t.timestamps
    end
  end
end
