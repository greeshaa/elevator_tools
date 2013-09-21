class CreateLifts < ActiveRecord::Migration
  def change
    create_table :lifts do |t|

      t.timestamps
    end
  end
end
