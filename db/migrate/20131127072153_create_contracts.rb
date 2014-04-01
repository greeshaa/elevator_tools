# -*- encoding : utf-8 -*-
class CreateContracts < ActiveRecord::Migration
  def change
    create_table :contracts do |t|
      t.belongs_to :partner
      t.string :number
      t.date :signed_at
      t.date :lifetime
      t.string :note

      t.timestamps
    end
  end
end
