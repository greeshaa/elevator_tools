# == Schema Information
#
# Table name: inspections
#
#  id                 :integer          not null, primary key
#  lift_id            :integer
#  inspection_at      :date
#  created_at         :datetime
#  updated_at         :datetime
#  next_inspection_at :date
#

# -*- encoding : utf-8 -*-
class Inspection < ActiveRecord::Base
  attr_accessible :inspection_at, :next_inspection_at

  belongs_to :lift

  before_save :inspection_shedule

  def inspection_shedule#(last_inspect_date)
  	#self.inspection_at = Date.today
    next_inspect_at = self.inspection_at.next_year()
    if next_inspect_at.cwday == 6
    	self.next_inspection_at = next_inspect_at.next_day(2)
    elsif next_inspect_at.cwday == 7
    	self.next_inspection_at = next_inspect_at.next_day()
    else
     self.next_inspection_at = next_inspect_at
    end
  end
end
