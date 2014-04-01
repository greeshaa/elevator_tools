# -*- encoding : utf-8 -*-
class CreateProviders < ActiveRecord::Migration
  def change
    create_table :providers do |t|
      t.string :name
      t.string :phone
      t.string :email
      t.string :contact
      t.string :note

      t.timestamps
    end
  end
end
