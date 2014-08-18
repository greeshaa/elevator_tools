class AddFloorToPrices < ActiveRecord::Migration
  def change
    add_column :prices, :floor, :integer
  end
end
