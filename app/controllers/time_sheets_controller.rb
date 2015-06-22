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
			if params[:date].nil?
				date = DateTime.now
				@date = date.to_s
			else
				date = DateTime.parse(params[:date])
				@date = params[:date]
			end
			smonth = date.beginning_of_month
			emonth = date.end_of_month
			holidays = []
			shortdays = []
			holidays  << DateTime.parse('01.05.2015')
			holidays  << DateTime.parse('04.05.2015')
			holidays  << DateTime.parse('11.05.2015')
			holidays  << DateTime.parse('12.06.2015')
			shortdays << DateTime.parse('08.05.2015')
			shortdays << DateTime.parse('11.06.2015')

			if params[:vacation_start_at].blank? && params[:vacation_end_at].blank?
				vacation_start = DateTime.parse('1970-01-01')
				vacation_end = DateTime.parse('1970-01-01')
			else
				vacation_start  = DateTime.parse(params[:vacation_start_at])
				vacation_end    = DateTime.parse(params[:vacation_end_at])
				vacation_start.upto(vacation_end) do |day|
					day_start = day.beginning_of_day.to_time #- 7.hours
					day_end = day.end_of_day.to_time #- 7.hours
					mechanic.time_sheets.create(time_sheet_kind_id: 9, start_at: day_start, end_at: day_end )
				end
			end
			if params[:sick_list_start_at].blank? && params[:sick_list_end_at].blank?
				sick_list_start = DateTime.parse('1970-01-01')
				sick_list_end = DateTime.parse('1970-01-01')
			else
				sick_list_start = DateTime.parse(params[:sick_list_start_at])
				sick_list_end   = DateTime.parse(params[:sick_list_end_at])
				sick_list_start.upto(sick_list_end) do |day|
					day_start = day.beginning_of_day.to_time# - 7.hours
					day_end =   day.end_of_day.to_time# - 7.hours
					mechanic.time_sheets.create(time_sheet_kind_id: 19, start_at: day_start, end_at: day_end )
				end
			end

			smonth.upto(emonth) do |day|
				if day.cwday == 6 || day.cwday == 7 || day.in?(holidays)
					if day >= vacation_start && day <= vacation_end || day >= sick_list_start && day <= sick_list_end
					else
							day_start = day.beginning_of_day.to_time# - 7.hours
							day_end = day.end_of_day.to_time# - 7.hours
							mechanic.time_sheets.create(time_sheet_kind_id: 26, start_at: day_start, end_at: day_end )
					end
				else
					if day >= vacation_start && day <= vacation_end || day >= sick_list_start && day <= sick_list_end
					else
						work_day_start = day.beginning_of_day.to_time + 2.hours
						if day.in?(shortdays)
							work_day_end = work_day_start.to_time + 4.hours
						else
							work_day_end = work_day_start.to_time + 8.hours
						end
						#work_day_end = work_day_start.to_time + 8.hours
						mechanic.time_sheets.create(time_sheet_kind_id: 1, start_at: work_day_start, end_at: work_day_end )
					end
				end
			end
			redirect_to timesheet_path
	end

	def timesheet
		@title = 'Табель учета рабочего времени'
		if current_user.foreman?
			foreman = Foreman.where('user_id = ?', current_user.id).first
			mechanics = Mechanic.all.where('foreman_id = ?', foreman.id).order(:name)
		else
			mechanics = Mechanic.all.order(:name)
		end
		if params[:date].nil?
			date = Date.today
		else
			date = Date.parse(params[:date])
		end
		@date = Russian::strftime(date, "%B") + ' ' + Russian::strftime(date, "%Y")
		smonth    = date.at_beginning_of_month
		emonth    = date.at_end_of_month
		@days 		= date.end_of_month.day
		@timesheets = []

		mechanics.each do |mechanic|
			array1 = []
			array1.push(mechanic)

			mechanic_timesheets = mechanic.time_sheets.where( start_at: smonth.beginning_of_day..emonth.end_of_day )
			if mechanic_timesheets.empty?
				array2 = []
				@days.times do
					array2.push('')
				end
			else
				array2 = []
				mechanic_timesheets.order(:start_at).each do |i|
					if i.time_sheet_kind_id == 1
						array2.push((i.end_at.to_time - i.start_at.to_time)/3600)
					else
						array2.push(i.time_sheet_kind.letter_code)
					end
				end
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
