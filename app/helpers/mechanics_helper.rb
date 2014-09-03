# -*- encoding : utf-8 -*-
module MechanicsHelper
	def lifts_zao(lifts)
		liftszao = lifts.where('tlr_id = ?', 1)
		@zlcount = liftszao.count
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
						downtimes_count = l.downtimes.where( dt_date: @smonth..@emonth ).count # количество простоев
						lift.push(downtimes_count)
						@totalzaodowntimes += downtimes_count
					else
						temp_start_at = l.temp_serv_meches.last.start_at
    	      temp_end_at   = l.temp_serv_meches.last.end_at
    	      all_downtimes_count = l.downtimes.where( dt_date: @smonth..@emonth ).count
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
	end

	def lifts_ooo(lifts)
		liftsooo = lifts.where('tlr_id = ?', 2)
		@olcount = liftsooo.count
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
						downtimes_count = l.downtimes.where( dt_date: @smonth..@emonth ).count # количество простоев
						lift.push(downtimes_count)
						@totalooodowntimes += downtimes_count
					else
						temp_start_at = l.temp_serv_meches.last.start_at
    	      temp_end_at   = l.temp_serv_meches.last.end_at
    	      all_downtimes_count = l.downtimes.where( dt_date: @smonth..@emonth ).count
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
	end

	def tmp_lifts(mechanic)
		@tsm = mechanic.temp_serv_meches.where("start_at BETWEEN ? AND ? OR end_at BETWEEN ? AND ?", @smonth, @emonth, @smonth, @emonth)
		@templift = []
		@tsm.each do |tsm|
			@templift.push(tsm.lift)
		end
		@templiftcount 	= @templift.count
	end

	def tmp_lifts_zao(lifts)
		lifts = @templift.find_all{|i| i.tlr_id == 1}
		@ztempliftcount = lifts.count
		@templiftszao = []
			if lifts.empty?
				@totaltzao = 0
				@totaltzaodowntimes = 0
				@tempz_accrual = 0
				@tempz_deduction = 0
			else
				@totaltzao = 0
				@totaltzaodowntimes = 0
				@tempz_accrual = 0
				@tempz_deduction = 0
				lifts.each do |l|
					lift = []
					lift.push(l)
					tsm = l.temp_serv_meches.last
					if tsm.start_at < @smonth
						if tsm.end_at > @emonth
							mech_work_days = @mech_work_days
						else
							mech_work_days = @smonth.business_days_until(tsm.end_at)
						end
					else
						if tsm.end_at > @emonth
							mech_work_days = tsm.start_at.business_days_until(@emonth)
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
	end

	def tmp_lifts_ooo(lifts)
		lifts = @templift.find_all{|i| i.tlr_id == 2}
		@otempliftcount = lifts.count
			@templiftsooo = []
			if lifts.empty?
				@totaltooo = 0
				@totaltooodowntimes = 0
				@tempo_accrual = 0
				@tempo_deduction = 0
			else
				@totaltooo = 0
				@totaltooodowntimes = 0
				@tempo_accrual = 0
				@tempo_deduction = 0
				lifts.each do |l|
					lift = []
					lift.push(l)
					tsm = l.temp_serv_meches.last
					if tsm.start_at < @smonth
						if tsm.end_at > @emonth
							mech_work_days = @mech_work_days
						else
							mech_work_days = @smonth.business_days_until(tsm.end_at)
						end
					else
						if tsm.end_at > @emonth
							mech_work_days = tsm.start_at.business_days_until(@emonth)
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
	end
end
