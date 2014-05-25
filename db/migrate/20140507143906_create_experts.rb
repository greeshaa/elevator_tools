# -*- encoding : utf-8 -*-
class CreateExperts < ActiveRecord::Migration
  def change
    create_table :experts do |t|
      t.integer :partner_id

      t.timestamps
    end
  end
end
