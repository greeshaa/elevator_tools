# -*- encoding : utf-8 -*-
class AddNamesToManufacturers < ActiveRecord::Migration
  def change
    add_column :manufacturers, :short_name, :string
    add_column :manufacturers, :full_name, :string
  end
end
