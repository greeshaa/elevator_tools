class CreateForemen < ActiveRecord::Migration
  def change
    create_table :foremen do |t|
      t.string :name
      t.integer :user_id

      t.timestamps
    end
  end
end
