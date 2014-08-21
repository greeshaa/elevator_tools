class FactoryCalendar < ActiveRecord::Base

  attr_accessible :month, :month_name, :cal_days, :work_days
end
