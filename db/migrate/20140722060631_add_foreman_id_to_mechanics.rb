# -*- encoding : utf-8 -*-
class AddForemanIdToMechanics < ActiveRecord::Migration
  def change
    add_column :mechanics, :foreman_id, :integer
  end
end
