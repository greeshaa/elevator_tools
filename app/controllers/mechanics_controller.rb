# -*- encoding : utf-8 -*-
class MechanicsController < ApplicationController
before_filter :signed_in_user
	def index
		if current_user.foreman?
			foreman = Foreman.where('user_id = ?', current_user.id).first
			@mechanics = Mechanic.all.where('foreman_id = ?', foreman.id).order(:name)
		else
			@mechanics = Mechanic.all.order(:name)
		end
	end

	def show
		@mechanic = Mechanic.find(params[:id])
		#@boss = @mechanic.
		if current_user.foreman?
			foreman = Foreman.where('user_id = ?', current_user.id).first
			@mechanics = Mechanic.all.where('foreman_id = ?', foreman.id).order(:name)
		else
			@mechanics = Mechanic.all.order(:name)
		end
		@lifts    = @mechanic.lifts.order(:tlr_id, :porch_id)
		@lcount 	= @lifts.count
		@zlcount 	= @lifts.where('tlr_id = ?', 1).count
		@olcount 	= @lifts.where('tlr_id = ?', 2).count
		@tsm = @mechanic.temp_serv_meches.where("start_at <? AND end_at >?", Date.today, Date.today)
		@templift = []
		@tsm.each do |tsm|
			@templift.push(tsm.lift)
		end
		@templiftcount 	= @templift.count
		@ztempliftcount = @templift.find_all{|i| i.tlr_id == 1}.count
		@otempliftcount = @templift.find_all{|i| i.tlr_id == 2}.count
		@allliftsum = @lcount + @templiftcount
		@zliftsum = @zlcount + @ztempliftcount
		@oliftsum = @olcount + @otempliftcount

	end

	def lift_move
		store_location
		@mechanic = Mechanic.find(params[:id])
		if current_user.foreman?
			foreman = Foreman.where('user_id = ?', current_user.id).first
			@mechanics = Mechanic.all.where('foreman_id = ?', foreman.id).order(:name)
		else
			@mechanics = Mechanic.all.order(:name)
		end
		@lifts    = @mechanic.lifts.order(:tlr_id, :porch_id)
		@lcount 	= @lifts.count
		@zlcount 	= @lifts.where('tlr_id = ?', 1).count
		@olcount 	= @lifts.where('tlr_id = ?', 2).count
		@tsm = @mechanic.temp_serv_meches.where("start_at <? AND end_at >?", Time.now, Time.now)
		@templift = []
		@tsm.each do |tsm|
			@templift.push(tsm.lift)
		end
		@templiftcount 	= @templift.count
		@ztempliftcount = @templift.find_all{|i| i.tlr_id == 1}.count
		@otempliftcount = @templift.find_all{|i| i.tlr_id == 2}.count
		@allliftsum     = @lcount + @templiftcount
		@zliftsum       = @zlcount + @ztempliftcount
		@oliftsum       = @olcount + @otempliftcount

	end

	def lift_move_zo
		store_location
		@mechanic = Mechanic.find(params[:id])
		@tlr = Tlr.all
		@lifts    = @mechanic.lifts.order(:tlr_id, :porch_id)
	end

	def work_order
		@mechanic  = Mechanic.find(params[:id])
		if params[:date].nil?
			@month = Date.today
		else
			@month = Date.parse(params[:date])
		end
		@smonth    = @month.at_beginning_of_month
		@emonth    = @month.at_end_of_month
		@cur_month = @month.month
		@cal_days  = FactoryCalendar.where('month = ?', @cur_month ).first.cal_days
		@work_days = FactoryCalendar.where('month = ?', @cur_month ).first.work_days
		@mech_work_days = @mechanic.time_sheets.where("time_sheet_kind_id = ? AND start_at >=? AND end_at <=?", 1, @smonth, @emonth).count

		@lifts     = @mechanic.lifts.order(:tlr_id, :porch_id)
		@lcount 	 = @lifts.count

		lifts_zao(@lifts)
		lifts_ooo(@lifts)
		tmp_lifts(@mechanic)
		tmp_lifts_zao(@templift)
		tmp_lifts_ooo(@templift)

		@allliftsum = @lcount + @templiftcount
		@zliftsum   = @zlcount + @ztempliftcount
		@oliftsum   = @olcount + @otempliftcount

		@totalown   = @totalzao + @totalooo
		@totaltmp   = @totaltzao + @totaltooo
		@total      = @totalown + @totaltmp
	end

	def work_order_for_all_mech
		#if params[:work_order_for_all_mech].nil?
		#	@month = Date.today
		#else
		#	@month = Date.parse(params[:work_order_for_all_mech])
		#end
		if params[:date].nil?
			@month = Date.today
		else
			@month = Date.parse(params[:date])
		end

		if current_user.foreman?
			foreman = Foreman.where('user_id = ?', current_user.id).first
			@mechanics = Mechanic.all.where('foreman_id = ?', foreman.id).order(:name)
		else
			@mechanics = Mechanic.all.order(:name)
		end

		@smonth     = @month.at_beginning_of_month
		@emonth     = @month.at_end_of_month
		@cur_month  = @month.month
		@cal_days  = FactoryCalendar.where('month = ?', @cur_month ).first.cal_days
		@work_days = FactoryCalendar.where('month = ?', @cur_month ).first.work_days
		@outputarray = []

		@mechanics.each do |mechanic|
			outputhash = Hash.new
			outputhash[:mechanic] = mechanic

			@mech_work_days = mechanic.time_sheets.where("time_sheet_kind_id = ? AND start_at >=? AND end_at <=?", 1, @smonth.beginning_of_day, @emonth.end_of_day).count
			outputhash[:mech_work_days] = @mech_work_days

			@lifts     = mechanic.lifts.order(:tlr_id, :porch_id)
			@lcount 	= @lifts.count

			if params[:tlr_id].nil?
				select = 0
				@select = "по всем лифтам"
			else
				select = params[:tlr_id].to_i
				if select != 0
					@select = "по лифтам " + Tlr.find_by_id(select).name
				else
					@select = "по всем лифтам"
				end
			end
			case select
				when 0
					lifts_zao(@lifts)
					lifts_ooo(@lifts)
					tmp_lifts(mechanic)
					tmp_lifts_zao(@templift)
					tmp_lifts_ooo(@templift)
					@allliftsum = @lcount + @templiftcount
				when 1
					lifts_zao(@lifts)
					@olcount = 0
					@totalooo = 0
					@owno_accrual = 0
					@owno_deduction = 0
					@totalooodowntimes = 0
					tmp_lifts(mechanic)
					tmp_lifts_zao(@templift)
					@otempliftcount = 0
					@totaltooo = 0
					@tempo_accrual = 0
					@tempo_deduction = 0
					@totaltooodowntimes = 0
					@allliftsum = @zlcount + @ztempliftcount
				when 2
					lifts_ooo(@lifts)
					@zlcount = 0
					@totalzao = 0
					@ownz_accrual = 0
					@ownz_deduction = 0
					@totalzaodowntimes = 0
					tmp_lifts(mechanic)
					tmp_lifts_ooo(@templift)
					@ztempliftcount = 0
					@totaltzao = 0
					@tempz_accrual = 0
					@tempz_deduction = 0
					@totaltzaodowntimes = 0
					@allliftsum = @olcount + @otempliftcount
				else
			end


			@zliftsum = @zlcount + @ztempliftcount
			@oliftsum = @olcount + @otempliftcount
			own_lifts_count = @zlcount + @olcount
			temp_lifts_count = @ztempliftcount + @otempliftcount

			@totalown = @totalzao + @totalooo
			@totaltmp = @totaltzao + @totaltooo
			@total = @totalown + @totaltmp

			@totalown_accrual = @ownz_accrual + @owno_accrual
			@totaltmp_accrual = @tempz_accrual + @tempo_accrual
			@total_accrual    = @totalown_accrual + @totaltmp_accrual

			@totalowndowntimes = @totalzaodowntimes + @totalooodowntimes
			@totaltmpdowntimes = @totaltzaodowntimes + @totaltooodowntimes
			@totaldowntimes = @totalowndowntimes + @totaltmpdowntimes

			@totalown_deduction = @owno_deduction + @ownz_deduction
			@totaltmp_deduction = @tempo_deduction + @tempz_deduction
			@total_deduction    = @totalown_deduction + @totaltmp_deduction

			outputhash[:all_lifts_count]      = @allliftsum
			outputhash[:own_lifts_count]      = own_lifts_count
			outputhash[:temp_lifts_count]     = temp_lifts_count
			outputhash[:all_lifts_accrual]    = @total_accrual
			outputhash[:own_lifts_accrual]    = @totalown_accrual
			outputhash[:temp_lifts_accrual]   = @totaltmp_accrual
			outputhash[:all_lifts_downtimes]  = @totaldowntimes
			outputhash[:own_lifts_downtimes]  = @totalowndowntimes
			outputhash[:temp_lifts_downtimes] = @totaltmpdowntimes
			outputhash[:all_lifts_deduction]  = @total_deduction
			outputhash[:own_lifts_deduction]  = @totalown_deduction
			outputhash[:temp_lifts_deduction] = @totaltmp_deduction
			outputhash[:all_lifts]            = @total
			outputhash[:own_lifts]            = @totalown
			outputhash[:temp_lifts]           = @totaltmp
			@outputarray.push(outputhash)
		end
	end

	def new
		@mechanic = Mechanic.new
		if current_user.foreman?
			@foreman = Foreman.where('user_id = ?', current_user.id)
		else
			@foreman = Foreman.all
		end
	end

	def create
		@mechanic = Mechanic.new(params[:mechanic])
    if @mechanic.save
    	okmessage = "Механик " + @mechanic.name + " успешно добавлен."
      flash[:success] = okmessage
      redirect_to @mechanic
    else
    	if current_user.foreman?
				@foreman = current_user
			else
				@foreman = User.where('foreman = ?', 1)
			end
      render :new
    end
	end

	def edit
		@mechanic = Mechanic.find(params[:id])
		if current_user.foreman?
			@foreman = current_user
		else
			@foreman = User.where('foreman = ?', 1)
		end
	end

	def update
		@mechanic = Mechanic.find(params[:id])
    if @mechanic.update_attributes(params[:mechanic])
    	okmessage = "Данные для " + @mechanic.name + " успешно изменены."
      flash[:success] = okmessage
      redirect_to @mechanic
    else
    	if current_user.foreman?
				@foreman = current_user
			else
				@foreman = User.where('foreman = ?', 1)
			end
      render :edit
    end
	end

	def destroy
    @mechanic = Mechanic.find(params[:id]).destroy
    flash[:success] = "Механик " + @mechanic.name + " удален."
    redirect_to mechanics_path
  end

end
