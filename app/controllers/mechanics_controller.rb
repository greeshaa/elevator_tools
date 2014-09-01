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
