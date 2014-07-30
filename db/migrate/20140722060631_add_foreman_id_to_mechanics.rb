class AddForemanIdToMechanics < ActiveRecord::Migration
  def change
    add_column :mechanics, :foreman_id, :integer
  end
end
