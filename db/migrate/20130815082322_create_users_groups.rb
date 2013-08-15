class CreateUsersGroups < ActiveRecord::Migration
  def change
    create_table :users_groups do |t|
      t.string :name

      t.timestamps
    end
  end
end
