# -*- encoding : utf-8 -*-
class LiftsController < ApplicationController
before_filter :signed_in_user

  def show
  	@lift   = Lift.find(params[:id])
  	@porch  = @lift.porch
    if @porch.nil?
      @build_name  = 'Номер здания неизвестен' 
      @street_name = 'Улица неизвестна'
      @city_name   = 'Населенный пункт неизвестен'

    else
  	@build  = @porch.build  
  	@street = @build.street
    @city   = @street.city
    @node   = @build.node
    end

    if @lift.introduced_at.nil?
    else
      @date_of_decommiss = @lift.introduced_at + @lift.standart_life
    end

    if @lift.temp_serv_meches.empty?
    else
    @temp_serv_mech = @lift.temp_serv_meches.last.mechanic  
    @temp_serv_mech_name = @temp_serv_mech.name
    @temp_serv_time = ("(c " + @lift.temp_serv_meches.last.start_at.strftime("%d.%m.%Y") + 
                      " по " + @lift.temp_serv_meches.last.end_at.strftime("%d.%m.%Y") + ")")
    end

  end

  def update
    @lift   = Lift.find(params[:id])
    if @lift.update_attributes(params[:lift]) 
      flash[:success] = "Лифт с регистрационным номером: " + @lift.regnum + " обновлен"
      redirect_to @lift
    else
      render 'edit'
    end
  end

  def index
  	#@lifts = Lift.search(params[:search])
    if (params[:search]).blank?
    else
      streets = Street.find(:all, :conditions => ['name LIKE ?', "%#{params[:search]}%"])
      if streets.empty?
        @lifts = Lift.search(params[:search])
      else
        @lifts = Lift.search(params[:search])
        streets.each do |s|
          lifts = s.lifts
          lifts.each do |n|
            @lifts.push(n)
          end
        end
      end   
    end 
  end

  def new
    @streets = Street.all
    @builds = Build.all
    @porch = Porch.all
    @lift = Lift.new 
  end

  def inspections
    @lifts = Lift.all
  end

  def current_month
    inspections = Inspection.where(next_inspection_at: Date.today.prev_month()..Date.today.next_month())  
      
  end

  def list
    @lifts = Lift.all
  end

  def fulliftsdata
    @lifts = Lift.all
    respond_to do |format|
      format.html
      format.xls # { render text: @lifts.to_csv }
    end
  end

  def lifts_of_nodes
    @lift  = Lift.find(params[:id])
    @lifts = @lift.node.lifts
    render "index"
  end

  def overdue_lifts
    @lifts = Lift.where('introduced_at <= ?', Date.today.year - 25 ).order(:introduced_at)
    render "index"
  end

  def move
    @mechanic = Mechanic.find(params[:mechanic_id])
    if params[:temporary] == "1"
      Lift.where(:id => params[:lift_ids]).each do |lift|
        TempServMech.create(lift_id: lift.id, mechanic_id: params[:mechanic_id], start_at: params[:start_at], end_at: params[:end_at])
      end
    else
      Lift.update_all(["mechanic_id=?", params[:mechanic_id]], :id => params[:lift_ids])
    end
    redirect_to @mechanic
  end
 
end
