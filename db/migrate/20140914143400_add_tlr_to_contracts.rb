class AddTlrToContracts < ActiveRecord::Migration
  def change
    add_column :contracts, :tlr_id, :integer
  end
end
