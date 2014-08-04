class MechanicsController < ApplicationController

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
		#@boss = @mechanic.
		@mechanics = Mechanic.all.order(:name)
		@lifts    = @mechanic.lifts.order(:tlr_id, :porch_id)
		@liftszao = @lifts.where('tlr_id = ?', 1)
		@liftsooo = @lifts.where('tlr_id = ?', 2)
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
