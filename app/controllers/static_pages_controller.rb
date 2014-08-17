# -*- encoding : utf-8 -*-
class StaticPagesController < ApplicationController
before_filter :signed_in_user

  def main
  	@equipment_movements      = EquipmentMovement.order(created_at: :desc).first(3)
  	@nodes_last 		 		      = Node.order(created_at: :desc).first(3)
  	inspection_last           = Inspection.where(created_at: (Date.today - 7.day)..Date.today + 1.day)
    @inspection_last          = inspection_last.order(created_at: :desc).first(3)
    @inspection_last_count    = inspection_last.count
  	inspection_next           = Inspection.where(next_inspection_at: Date.today..(Date.today + 7.day)).order(:next_inspection_at)
    @inspection_next          = inspection_next.first(3)
    @inspection_next_count    = inspection_next.count
  	@infomessages 			      = []
    inspection_overdue        = Inspection.where(active: true).where(next_inspection_at: (Date.today - Time.now.to_a[7])..(Date.today - 1.day))
    @inspection_overdue       = inspection_overdue.first(3)
    @inspection_overdue_count = inspection_overdue.count
    lifts              = Lift.where('introduced_at <= ?', Date.today.year - 25 )
    lift_overdue = []
    lifts.each do |l|
      if l.overhauls.empty?
        lift_overdue.push(l)
      else
        if l.overhauls.last.produced_at < (Date.today.year - l.overhauls.last.new_lifetime)
          lift_overdue.push(l)
        end
      end
    end
    @lift_overdue             = lift_overdue.first(3)
    @lift_overdue_count       = lift_overdue.count
  end

  def about
  end

  def statistics
  end

end
