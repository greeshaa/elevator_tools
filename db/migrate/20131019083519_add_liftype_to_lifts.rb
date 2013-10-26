class AddLiftypeToLifts < ActiveRecord::Migration
  def change
    add_column :lifts, :lifttype, :string
  end
end
