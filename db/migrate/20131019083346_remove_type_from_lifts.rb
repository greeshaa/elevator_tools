class RemoveTypeFromLifts < ActiveRecord::Migration
  def up
    remove_column :lifts, :type
  end

  def down
    add_column :lifts, :type, :string
  end
end
