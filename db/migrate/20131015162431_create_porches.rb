# -*- encoding : utf-8 -*-
class CreatePorches < ActiveRecord::Migration
  def change
    create_table :porches do |t|
      t.belongs_to :build
      t.string :name

      t.timestamps
     end
  end
end
