class AddStreetKindIdToStreet < ActiveRecord::Migration
  def change
    add_column :streets, :street_kind_id, :integer
  end
end
