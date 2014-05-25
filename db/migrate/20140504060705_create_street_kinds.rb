# -*- encoding : utf-8 -*-
class CreateStreetKinds < ActiveRecord::Migration
  def change
    create_table :street_kinds do |t|
      t.string :name
      t.string :full_name

      t.timestamps
    end
  end
end
