# -*- encoding : utf-8 -*-
class TimeSheetKind < ActiveRecord::Base
	has_many :time_sheets
end
