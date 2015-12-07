class AddActiveToContracts < ActiveRecord::Migration
  def change
    add_column :contracts, :active, :boolean, default: true
  end
end
