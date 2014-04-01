# -*- encoding : utf-8 -*-
class CreateDestinations < ActiveRecord::Migration
  def change
    create_table :destinations do |t|
      t.belongs_to :node
      t.belongs_to :lift
      t.string :name

      t.timestamps
    end
  end
end
