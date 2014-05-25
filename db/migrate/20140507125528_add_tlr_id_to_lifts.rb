# -*- encoding : utf-8 -*-
class AddTlrIdToLifts < ActiveRecord::Migration
  def change
    add_column :lifts, :tlr_id, :integer
    add_column :lifts, :district_id, :integer
    add_column :lifts, :service_payment, :string
    add_column :lifts, :expert_id, :integer
  end
end
