# -*- encoding : utf-8 -*-
class StaticPagesController < ApplicationController
before_filter :signed_in_user

  def main
  	@equipment_movements = EquipmentMovement.order(created_at: :desc).first(3)
  	@nodes_last 		 		 = Node.order(created_at: :desc).first(3)
  	@inspection_last     = Inspection.where(inspection_at: (Date.today - 7.day)..Date.today).first(3)
  	@inspection_next     = Inspection.where(next_inspection_at: Date.today..(Date.today + 7.day)).first(3)
  	@infomessages 			 = []
    inspection_overdue   = Inspection.where(created_at: ((Date.today - Time.now.to_a[7]).prev_year()..Date.today - Time.now.to_a[7])).where(next_inspection_at: (Date.today - Time.now.to_a[7])..(Date.today - 1.day))
    @inspection_overdue  = inspection_overdue.first(3)
    @inspection_overdue_count  = inspection_overdue.count
    lift_overdue         = Lift.where('introduced_at <= (2014-25)')
    @lift_overdue        = lift_overdue.first(3)
    @lift_overdue_count  = lift_overdue.count
  end

  def about
  end

  def statistics
  end

end
