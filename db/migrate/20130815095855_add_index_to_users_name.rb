# -*- encoding : utf-8 -*-
class AddIndexToUsersName < ActiveRecord::Migration
  def change
  	add_index :users, :name, unique: true
  end
end
