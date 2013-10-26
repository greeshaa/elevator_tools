# -*- encoding : utf-8 -*-
class AddRunameToUsers < ActiveRecord::Migration
  def change
  	add_column :users, :runame, :string
  end
end
