# -*- encoding : utf-8 -*-
class CreatePrices < ActiveRecord::Migration
  def change
    create_table :prices do |t|
      t.string :title
      t.string :description
      t.decimal :cost, precision: 4, scale: 2

      t.timestamps
    end
  end
end
