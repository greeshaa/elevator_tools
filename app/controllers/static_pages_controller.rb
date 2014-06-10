# -*- encoding : utf-8 -*-
class StaticPagesController < ApplicationController
before_filter :signed_in_user

  def main
  	@equipment_movements      = EquipmentMovement.order(created_at: :desc).first(3)
  	@nodes_last 		 		      = Node.order(created_at: :desc).first(3)
  	inspection_last           = Inspection.where(created_at: (Date.today - 7.day)..Date.today + 1.day)
    @inspection_last          = inspection_last.last(3).order(:created_at)
    @inspection_last_count    = inspection_last.count
  	inspection_next           = Inspection.where(next_inspection_at: Date.today..(Date.today + 7.day))
    @inspection_next          = inspection_next.first(3)
    @inspection_next_count    = inspection_next.count
  	@infomessages 			      = []
    inspection_overdue        = Inspection.where(active: true).where(next_inspection_at: (Date.today - Time.now.to_a[7])..(Date.today - 1.day))
    @inspection_overdue       = inspection_overdue.first(3)
    @inspection_overdue_count = inspection_overdue.count
    lift_overdue              = Lift.where('introduced_at <= ?', Date.today.year - 25 )
    @lift_overdue             = lift_overdue.first(3)
    @lift_overdue_count       = lift_overdue.count
  end

  def about
  end

  def statistics
  end

end
