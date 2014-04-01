# -*- encoding : utf-8 -*-
class AddPorchesToBuilds < ActiveRecord::Migration
  def change
    add_column :builds, :porch_count, :integer
  end
end
