# -*- encoding : utf-8 -*-
class AddCityIdToStreets < ActiveRecord::Migration
  def change
  	add_column :streets, :city_id, :integer
  end
end
