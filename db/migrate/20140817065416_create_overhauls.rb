class CreateOverhauls < ActiveRecord::Migration
  def change
    create_table :overhauls do |t|
      t.string :kind
      t.date :produced_at
      t.string :description
      t.integer :new_lifetime
      t.integer :lift_id
      t.boolean :active, default: true

      t.timestamps
    end
  end
end
