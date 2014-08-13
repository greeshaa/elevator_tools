# -*- encoding : utf-8 -*-
class AddPriceIdToLifts < ActiveRecord::Migration
  def change
    add_column :lifts, :price_id, :integer
  end
end
