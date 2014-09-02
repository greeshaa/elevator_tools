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
		@tsm = @mechanic.temp_serv_meches.where("start_at <? AND end_at >?", Time.now, Time.now)
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
		session[:return_to] ||= request.referer
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
		session[:return_to] ||= request.referer
		@mechanic = Mechanic.find(params[:id])
		@tlr = Tlr.all
		@lifts    = @mechanic.lifts.order(:tlr_id, :porch_id)
	end

	def work_order
		@mechanic  = Mechanic.find(params[:id])
		@month     = Date.parse('2014-08-03')
		smonth     = @month.at_beginning_of_month
		emonth     = @month.at_end_of_month
		cur_month  = @month.month
		@cal_days  = FactoryCalendar.where('month = ?', cur_month ).first.cal_days
		@work_days = FactoryCalendar.where('month = ?', cur_month ).first.work_days
		@mech_work_days = 21

		#@boss = @mechanic.
		@mechanics = Mechanic.all.order(:name)
		@lifts     = @mechanic.lifts.order(:tlr_id, :porch_id)
		liftszao   = @lifts.where('tlr_id = ?', 1)
		@liftszao = []
		if liftszao.empty?
			@totalzao = 0
		else
			@totalzao = 0
			liftszao.each do |l|
				lift = []
				lift.push(l)
				accrual = (l.price.cost / @work_days) * @mech_work_days if l.price != nil # стоимость обслуживания лифта в день
				lift.push(accrual)
				if l.temp_serv_meches.empty?
					downtimes_count = l.downtimes.where( dt_date: smonth..emonth ).count # количество простоев
					lift.push(downtimes_count)
				else
					temp_start_at = l.temp_serv_meches.last.start_at
          temp_end_at   = l.temp_serv_meches.last.end_at
          all_downtimes_count = l.downtimes.where( dt_date: smonth..emonth ).count
          temp_downtimes_count = l.downtimes.where( dt_date: temp_start_at..temp_end_at ).count
          downtimes_count = all_downtimes_count = temp_downtimes_count
					lift.push(downtimes_count)
				end
				deduction = (l.price.cost / @cal_days) * downtimes_count if l.price != nil # удержание за простои
				lift.push(deduction)
				if l.price != nil # итого к выплате
					total = accrual - deduction
				else
					total = 0
				end
				lift.push(total)
				@liftszao.push(lift)
				@totalzao += total
			end
		end

		liftsooo = @lifts.where('tlr_id = ?', 2)
		@liftsooo = []
		if liftsooo.empty?
			@totalooo = 0
		else
			@totalooo = 0
			liftsooo.each do |l|
				lift = []
				lift.push(l)
				accrual = (l.price.cost / @work_days) * @mech_work_days if l.price != nil # стоимость обслуживания лифта в день
				lift.push(accrual)
				if l.temp_serv_meches.empty?
					downtimes_count = l.downtimes.where( dt_date: smonth..emonth ).count # количество простоев
					lift.push(downtimes_count)
				else
					temp_start_at = l.temp_serv_meches.last.start_at
          temp_end_at   = l.temp_serv_meches.last.end_at
          all_downtimes_count = l.downtimes.where( dt_date: smonth..emonth ).count
          temp_downtimes_count = l.downtimes.where( dt_date: temp_start_at..temp_end_at ).count
          downtimes_count = all_downtimes_count = temp_downtimes_count
					lift.push(downtimes_count)
				end
				deduction = (l.price.cost / @cal_days) * downtimes_count if l.price != nil# удержание за простои
				lift.push(deduction)
				if l.price != nil # итого к выплате
					total = accrual - deduction
				else
					total = 0
				end
				lift.push(total)
				@liftsooo.push(lift)
				@totalooo += total
			end
		end

		@lcount 	= @lifts.count
		@zlcount 	= @lifts.where('tlr_id = ?', 1).count
		@olcount 	= @lifts.where('tlr_id = ?', 2).count
		@tsm = @mechanic.temp_serv_meches.where("start_at BETWEEN ? AND ? OR end_at BETWEEN ? AND ?", smonth, emonth, smonth, emonth)
		@templift = []
		@tsm.each do |tsm|
			@templift.push(tsm.lift)
		end

		templiftszao = @templift.find_all{|i| i.tlr_id == 1}
		@templiftszao = []
		if templiftszao.empty?
			@totaltzao = 0
		else
			@totaltzao = 0
			templiftszao.each do |l|
				lift = []
				lift.push(l)
				tsm = l.temp_serv_meches.last
				if tsm.start_at < smonth
					if tsm.end_at > emonth
						mech_work_days = @mech_work_days
					else
						mech_work_days = smonth.business_days_until(tsm.end_at)
					end
				else
					if tsm.end_at > emonth
						mech_work_days = tsm.start_at.business_days_until(emonth)
					else
						mech_work_days = tsm.start_at.business_days_until(tsm.end_at)
					end
				end

				accrual = (l.price.cost / @work_days) * mech_work_days if l.price != nil # стоимость обслуживания лифта в день
				lift.push(accrual)
				downtimes_count = l.downtimes.where({ dt_date: tsm.start_at..tsm.end_at }).count # количество простоев
				lift.push(downtimes_count)
				deduction = (l.price.cost / @cal_days) * downtimes_count if l.price != nil# удержание за простои
				lift.push(deduction)
				if l.price != nil # итого к выплате
					total = accrual - deduction
				else
					total = 0
				end
				lift.push(total)
				lift.push(mech_work_days)
				@templiftszao.push(lift)
				@totaltzao += total
			end
		end

		templiftsooo = @templift.find_all{|i| i.tlr_id == 2}
		@templiftsooo = []
		if templiftsooo.empty?
			@totaltooo = 0
		else
			@totaltooo = 0
			templiftsooo.each do |l|
				lift = []
				lift.push(l)
				tsm = l.temp_serv_meches.last
				if tsm.start_at < smonth
					if tsm.end_at > emonth
						mech_work_days = @mech_work_days
					else
						mech_work_days = smonth.business_days_until(tsm.end_at)
					end
				else
					if tsm.end_at > emonth
						mech_work_days = tsm.start_at.business_days_until(emonth)
					else
						mech_work_days = tsm.start_at.business_days_until(tsm.end_at)
					end
				end

				accrual = (l.price.cost / @work_days) * mech_work_days if l.price != nil # стоимость обслуживания лифта в день
				lift.push(accrual)
				downtimes_count = l.downtimes.where({ dt_date: tsm.start_at..tsm.end_at }).count # количество простоев
				lift.push(downtimes_count)
				deduction = (l.price.cost / @cal_days) * downtimes_count if l.price != nil# удержание за простои
				lift.push(deduction)
				if l.price != nil # итого к выплате
					total = accrual - deduction
				else
					total = 0
				end
				lift.push(total)
				lift.push(mech_work_days)
				@templiftsooo.push(lift)
				@totaltooo += total
			end
		end

		@templiftcount 	= @templift.count
		@ztempliftcount = @templift.find_all{|i| i.tlr_id == 1}.count
		@otempliftcount = @templift.find_all{|i| i.tlr_id == 2}.count
		@allliftsum = @lcount + @templiftcount
		@zliftsum = @zlcount + @ztempliftcount
		@oliftsum = @olcount + @otempliftcount

		@totalown = @totalzao + @totalooo
		@totaltmp = @totaltzao + @totaltooo
		@total = @totalown + @totaltmp
	end

	def work_order_for_all_mech
		if current_user.foreman?
			foreman = Foreman.where('user_id = ?', current_user.id).first
			@mechanics = Mechanic.all.where('foreman_id = ?', foreman.id).order(:name)
		else
			@mechanics = Mechanic.all.order(:name)
		end
		@month     = Date.parse('2014-08-03')
		smonth     = @month.at_beginning_of_month
		emonth     = @month.at_end_of_month
		cur_month  = @month.month
		@cal_days  = FactoryCalendar.where('month = ?', cur_month ).first.cal_days
		@work_days = FactoryCalendar.where('month = ?', cur_month ).first.work_days
		@outputarray = []

		@mechanics.each do |mechanic|
			outputhash = Hash.new
			outputhash[:mechanic] = mechanic

			@mech_work_days = 21
			outputhash[:mech_work_days] = @mech_work_days

			@lifts     = mechanic.lifts.order(:tlr_id, :porch_id)
			liftszao   = @lifts.where('tlr_id = ?', 1)
			@liftszao = []
			if liftszao.empty?
				@totalzao = 0
				@totalzaodowntimes = 0
				@ownz_accrual = 0
				@ownz_deduction = 0
			else
				@totalzao = 0
				@totalzaodowntimes = 0
				@ownz_accrual = 0
				@ownz_deduction = 0
				liftszao.each do |l|
					lift = []
					lift.push(l)
					accrual = (l.price.cost / @work_days) * @mech_work_days if l.price != nil # стоимость обслуживания лифта в день
					lift.push(accrual)
					@ownz_accrual += accrual if l.price != nil
					if l.temp_serv_meches.empty?
						downtimes_count = l.downtimes.where( dt_date: smonth..emonth ).count # количество простоев
						lift.push(downtimes_count)
						@totalzaodowntimes += downtimes_count
					else
						temp_start_at = l.temp_serv_meches.last.start_at
    	      temp_end_at   = l.temp_serv_meches.last.end_at
    	      all_downtimes_count = l.downtimes.where( dt_date: smonth..emonth ).count
    	      temp_downtimes_count = l.downtimes.where( dt_date: temp_start_at..temp_end_at ).count
    	      downtimes_count = all_downtimes_count - temp_downtimes_count
						lift.push(downtimes_count)
						@totalzaodowntimes += downtimes_count
					end
					deduction = (l.price.cost / @cal_days) * downtimes_count if l.price != nil # удержание за простои
					lift.push(deduction)
					@ownz_deduction += deduction if l.price != nil
					if l.price != nil # итого к выплате
						total = accrual - deduction
					else
						total = 0
					end
					lift.push(total)
					@liftszao.push(lift)
					@totalzao += total
				end
			end

			liftsooo = @lifts.where('tlr_id = ?', 2)
			@liftsooo = []
			if liftsooo.empty?
				@totalooo = 0
				@totalooodowntimes = 0
				@owno_accrual = 0
				@owno_deduction = 0
			else
				@totalooo = 0
				@totalooodowntimes = 0
				@owno_accrual = 0
				@owno_deduction = 0
				liftsooo.each do |l|
					lift = []
					lift.push(l)
					accrual = (l.price.cost / @work_days) * @mech_work_days if l.price != nil # стоимость обслуживания лифта в день
					lift.push(accrual)
					@owno_accrual += accrual if l.price != nil
					if l.temp_serv_meches.empty?
						downtimes_count = l.downtimes.where( dt_date: smonth..emonth ).count # количество простоев
						lift.push(downtimes_count)
						@totalooodowntimes += downtimes_count
					else
						temp_start_at = l.temp_serv_meches.last.start_at
    	      temp_end_at   = l.temp_serv_meches.last.end_at
    	      all_downtimes_count = l.downtimes.where( dt_date: smonth..emonth ).count
    	      temp_downtimes_count = l.downtimes.where( dt_date: temp_start_at..temp_end_at ).count
    	      downtimes_count = all_downtimes_count = temp_downtimes_count
						lift.push(downtimes_count)
						@totalooodowntimes += downtimes_count
					end
					deduction = (l.price.cost / @cal_days) * downtimes_count if l.price != nil# удержание за простои
					lift.push(deduction)
					@owno_deduction += deduction if l.price != nil
					if l.price != nil # итого к выплате
						total = accrual - deduction
					else
						total = 0
					end
					lift.push(total)
					@liftsooo.push(lift)
					@totalooo += total
				end
			end

			@lcount 	= @lifts.count
			@zlcount 	= @lifts.where('tlr_id = ?', 1).count
			@olcount 	= @lifts.where('tlr_id = ?', 2).count
			@tsm = mechanic.temp_serv_meches.where("start_at BETWEEN ? AND ? OR end_at BETWEEN ? AND ?", smonth, emonth, smonth, emonth)
			@templift = []
			@tsm.each do |tsm|
				@templift.push(tsm.lift)
			end

			templiftszao = @templift.find_all{|i| i.tlr_id == 1}
			@templiftszao = []
			if templiftszao.empty?
				@totaltzao = 0
				@totaltzaodowntimes = 0
				@tempz_accrual = 0
				@tempz_deduction = 0
			else
				@totaltzao = 0
				@totaltzaodowntimes = 0
				@tempz_accrual = 0
				@tempz_deduction = 0
				templiftszao.each do |l|
					lift = []
					lift.push(l)
					tsm = l.temp_serv_meches.last
					if tsm.start_at < smonth
						if tsm.end_at > emonth
							mech_work_days = @mech_work_days
						else
							mech_work_days = smonth.business_days_until(tsm.end_at)
						end
					else
						if tsm.end_at > emonth
							mech_work_days = tsm.start_at.business_days_until(emonth)
						else
							mech_work_days = tsm.start_at.business_days_until(tsm.end_at)
						end
					end

					accrual = (l.price.cost / @work_days) * mech_work_days if l.price != nil # стоимость обслуживания лифта в день
					lift.push(accrual)
					@tempz_accrual += accrual if l.price != nil
					downtimes_count = l.downtimes.where({ dt_date: tsm.start_at..tsm.end_at }).count # количество простоев
					lift.push(downtimes_count)
					@totaltzaodowntimes += downtimes_count
					deduction = (l.price.cost / @cal_days) * downtimes_count if l.price != nil# удержание за простои
					lift.push(deduction)
					@tempz_deduction += deduction if l.price != nil
					if l.price != nil # итого к выплате
						total = accrual - deduction
					else
						total = 0
					end
					lift.push(total)
					lift.push(mech_work_days)
					@templiftszao.push(lift)
					@totaltzao += total
				end
			end

			templiftsooo = @templift.find_all{|i| i.tlr_id == 2}
			@templiftsooo = []
			if templiftsooo.empty?
				@totaltooo = 0
				@totaltooodowntimes = 0
				@tempo_accrual = 0
				@tempo_deduction = 0
			else
				@totaltooo = 0
				@totaltooodowntimes = 0
				@tempo_accrual = 0
				@tempo_deduction = 0
				templiftsooo.each do |l|
					lift = []
					lift.push(l)
					tsm = l.temp_serv_meches.last
					if tsm.start_at < smonth
						if tsm.end_at > emonth
							mech_work_days = @mech_work_days
						else
							mech_work_days = smonth.business_days_until(tsm.end_at)
						end
					else
						if tsm.end_at > emonth
							mech_work_days = tsm.start_at.business_days_until(emonth)
						else
							mech_work_days = tsm.start_at.business_days_until(tsm.end_at)
						end
					end

					accrual = (l.price.cost / @work_days) * mech_work_days if l.price != nil # стоимость обслуживания лифта в день
					lift.push(accrual)
					@tempo_accrual += accrual if l.price != nil
					downtimes_count = l.downtimes.where({ dt_date: tsm.start_at..tsm.end_at }).count # количество простоев
					lift.push(downtimes_count)
					@totaltooodowntimes += downtimes_count
					deduction = (l.price.cost / @cal_days) * downtimes_count if l.price != nil# удержание за простои
					lift.push(deduction)
					@tempo_deduction += deduction if l.price != nil
					if l.price != nil # итого к выплате
						total = accrual - deduction
					else
						total = 0
					end
					lift.push(total)
					lift.push(mech_work_days)
					@templiftsooo.push(lift)
					@totaltooo += total
				end
			end

			@templiftcount 	= @templift.count
			@ztempliftcount = @templift.find_all{|i| i.tlr_id == 1}.count
			@otempliftcount = @templift.find_all{|i| i.tlr_id == 2}.count
			@allliftsum = @lcount + @templiftcount
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

			@totalown_deduction = @owno_deduction + @ownz_deduction
			@totaltmp_deduction = @tempo_deduction + @tempz_deduction
			@total_deduction    = @totalown_deduction + @totaltmp_deduction

			outputhash[:all_lifts_count]      = @allliftsum
			outputhash[:own_lifts_count]      = own_lifts_count
			outputhash[:temp_lifts_count]     = temp_lifts_count
			outputhash[:all_lifts_accrual]    = @total_accrual
			outputhash[:own_lifts_accrual]    = @totalown_accrual
			outputhash[:temp_lifts_accrual]   = @totaltmp_accrual
			outputhash[:all_lifts_downtimes]  = @totalzaodowntimes + @totalooodowntimes + @totaltzaodowntimes + @totaltooodowntimes
			outputhash[:own_lifts_downtimes]  = @totalzaodowntimes + @totalooodowntimes
			outputhash[:temp_lifts_downtimes] = @totaltzaodowntimes + @totaltooodowntimes
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
