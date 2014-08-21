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

	def work_order
		@mechanic = Mechanic.find(params[:id])
		@month = Date.today
		@mech_work_days = 10
		@cal_days = 23

		#@boss = @mechanic.
		@mechanics = Mechanic.all.order(:name)
		@lifts    = @mechanic.lifts.order(:tlr_id, :porch_id)
		liftszao = @lifts.where('tlr_id = ?', 1)
		if liftszao.empty?
		else
			@liftszao = []
			@totalzao = 0
			liftszao.each do |l|
				lift = []
				lift.push(l)
				accrual = (l.price.cost / @cal_days) * @mech_work_days if l.price != nil # стоимость обслуживания лифта в день
				lift.push(accrual)
				downtimes_count = l.downtimes.where({ dt_date: @month.at_beginning_of_month..@month.at_end_of_month }).count # количество простоев
				lift.push(downtimes_count)
				deduction = (downtimes_count / @cal_days) * @mech_work_days # удержание за простои
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
		if liftsooo.empty?
		else
			@liftsooo = []
			@totalooo = 0
			liftsooo.each do |l|
				lift = []
				lift.push(l)
				accrual = (l.price.cost / @cal_days) * @mech_work_days if l.price != nil # стоимость обслуживания лифта в день
				lift.push(accrual)
				downtimes_count = l.downtimes.where({ dt_date: @month.at_beginning_of_month..@month.at_end_of_month }).count # количество простоев
				lift.push(downtimes_count)
				deduction = (downtimes_count / @cal_days) * @mech_work_days # удержание за простои
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
		@tsm = @mechanic.temp_serv_meches.where("start_at <? AND end_at >?", Time.now, Time.now)
		@templift = []
		@tsm.each do |tsm|
			@templift.push(tsm.lift)
		end

		@templiftszao = @templift.find_all{|i| i.tlr_id == 1}
		@templiftsooo = @templift.find_all{|i| i.tlr_id == 2}

		@templiftcount 	= @templift.count
		@ztempliftcount = @templift.find_all{|i| i.tlr_id == 1}.count
		@otempliftcount = @templift.find_all{|i| i.tlr_id == 2}.count
		@allliftsum = @lcount + @templiftcount
		@zliftsum = @zlcount + @ztempliftcount
		@oliftsum = @olcount + @otempliftcount

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
