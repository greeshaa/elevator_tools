# -*- encoding : utf-8 -*-
class TimeSheetsController < ApplicationController
	before_filter :signed_in_user

	def index
		@timesheets = TimeSheet.all
	end

	def new
		@title = 'Добавление отработанных часов механика'
		if current_user.foreman?
			foreman = Foreman.where('user_id = ?', current_user.id).first
			@mechanics = Mechanic.all.where('foreman_id = ?', foreman.id).order(:name)
		else
			@mechanics = Mechanic.all.order(:name)
		end
		@timesheet = TimeSheet.new
	end

	def create
			mechanic = Mechanic.find(params[:time_sheet]["mechanic_id"])
			date = DateTime.now
			smonth = date.beginning_of_month
			emonth = date.end_of_month
			smonth.upto(emonth) do |day|
				if day.cwday == 6 || day.cwday == 7
				else
					work_days_start = day.beginning_of_day.to_time + 8.hours
					work_days_end = work_days_start.to_time + 8.hours
					mechanic.time_sheets.create(time_sheet_kind_id: 1, start_at: work_days_start, end_at: work_days_end )
				end
			end
			redirect_to timesheet_path
	end

	def timesheet
		@title = 'Табель учета рабочего времени'
		mechanics = Mechanic.all.order(:name)
		date      = DateTime.now #parse('2014-04-14')
		smonth    = date.at_beginning_of_month
		emonth    = date.at_end_of_month
		@days 		= date.end_of_month.day
		@timesheets = []
		mechanics.each do |mechanic|
			array1 = []
			array1.push(mechanic)
			mechanic_timesheets = mechanic.time_sheets.where( start_at: smonth..emonth )
			if mechanic_timesheets.empty?
				array2 = []
				@days.times do
					array2.push('')
				end
			else
				array2 = []
				i_count = 0
				mechanic_timesheets.each do |i|
					if i.start_at == smonth
						timesheet_hours = (i.end_at - i.start_at)/3600
						if timesheet_hours < 24
							day_work_time = timesheet_hours
							array2.push(day_work_time)
						else
							event_days = (timesheet_hours/24).to_i + 1
							event_days.times {array2.push(i.time_sheet_kind.letter_code)}
						end
						i_count =+ 1
					else
						if i_count == 0
							skip_days = (i.start_at - smonth).to_i/86400
							skip_days.times {array2.push('')}
							timesheet_hours = (i.end_at - i.start_at)/3600
							if timesheet_hours < 24
								day_work_time = timesheet_hours
								array2.push(day_work_time)
							else
								event_days = (timesheet_hours/24).to_i + 1
								event_days.times {array2.push(i.time_sheet_kind.letter_code)}
							end
							i_count =+ 1
						else
							skip_days = (i.start_at.day - array2.count) - 1
							skip_days.times {array2.push('')}
							timesheet_hours = (i.end_at - i.start_at)/3600
							if timesheet_hours < 24
								day_work_time = timesheet_hours
								array2.push(day_work_time)
							else
								event_days = (timesheet_hours/24).to_i + 1
								event_days.times {array2.push(i.time_sheet_kind.letter_code)}
							end
							i_count =+ 1
						end
					end
					@i_count = i_count
				end
				@array2_count = array2.count
				(@days - array2.count).times {array2.push('')} if array2.count < @days
				#array2.map!{ |elem| elem = 'В' if  }
			end
			array1.push(array2)
			@timesheets.push(array1)
		end
	end

	def add_vacation
		@title = 'Отпуск для механика'
		@mechanics = Mechanic.all.order(:name)
		@timesheet = TimeSheet.new
	end

	def vacation_save
		if vacation = TimeSheet.create(params[:time_sheet])
			vacation.update_attributes(time_sheet_kind_id: 9)
			redirect_to timesheet_path
		else
      render 'add_vacation'
		end
	end

	def add_sick_list
		@title = 'Больничный лист'
		@mechanics = Mechanic.all.order(:name)
		@timesheet = TimeSheet.new
	end

	def sick_list_save
		if sick_list = TimeSheet.create(params[:time_sheet])
			sick_list.update_attributes(time_sheet_kind_id: 19)
			redirect_to timesheet_path
		else
      render 'add_sick_list'
		end
	end

	def add_work_days
		@title = 'Отпуск для механика'
		@mechanics = Mechanic.all.order(:name)
		@timesheet = TimeSheet.new
	end

	def work_days_save
		parameters = params[:time_sheet]
		start = parameters[:start_at]
	end
end
