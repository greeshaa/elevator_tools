# -*- encoding : utf-8 -*-
class LiftsController < ApplicationController
before_filter :signed_in_user

  def new
    @districts = District.all
    @streets = Street.all
    @builds = Build.all
    @porch = Porch.all
    @nodes = Node.all
    @mechanics = Mechanic.all
    @tlr = Tlr.all
    @lift = Lift.new
  end

  def create
    lift_data = params[:lift]
    lift_data.delete("street")
    lift_data.delete("build")
    @lift = Lift.new(lift_data)
    if @lift.save
      okmessage = "Лифт добавлен в базу данных."
      flash[:success] = okmessage
      redirect_to @lift
    else
      @districts = District.all
      @streets = Street.all
      @builds = Build.all
      @porch = Porch.all
      @nodes = Node.all
      @mechanics = Mechanic.all
      @tlr = Tlr.all
      render 'new'
    end

  end

  def edit
    @lift   = Lift.find(params[:id])
    @districts = District.all
    @streets = Street.all
    @builds = Build.all
    @porch = Porch.all
    @nodes = Node.all
    @mechanics = Mechanic.all
    @tlr = Tlr.all
  end

  def update
    @lift   = Lift.find(params[:id])
    lift_data = params[:lift]
    lift_data.delete("street")
    lift_data.delete("build")
    if @lift.update_attributes(lift_data)
      flash[:success] = "Лифт с регистрационным номером: " + @lift.regnum + " обновлен"
      redirect_to @lift
    else
      render 'edit'
    end
  end

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
      if @lift.overhauls.empty?
        @date_of_decommiss = @lift.introduced_at + @lift.standart_life
      else
        @date_of_decommiss = (@lift.overhauls.last.produced_at + @lift.overhauls.last.new_lifetime*365).strftime("%Y")
      end

    end

    if @lift.temp_serv_meches.empty?
    else
    @temp_serv_mech = @lift.temp_serv_meches.last.mechanic
    @temp_serv_mech_name = @temp_serv_mech.name
    @temp_serv_time = ("(c " + @lift.temp_serv_meches.last.start_at.strftime("%d.%m.%Y") +
                      " по " + @lift.temp_serv_meches.last.end_at.strftime("%d.%m.%Y") + ")")
    end

  end

  def index
  	#@lifts = Lift.search(params[:search])
    if (params[:search]).blank?
      @title = 'Информация по облуживаемым лифтам'
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
      @title = 'Результаты поиска по запросу "' + params[:search] + '"'
      @link_name = 'ПТО'
    end
  end

  def inspections
    @lifts = Lift.all
  end

  def current_month
    inspections = Inspection.where(next_inspection_at: Date.today.prev_month()..Date.today.next_month())

  end

  def list
    @lifts = Lift.all
    @title = 'Все зарегистрированные в системе лифты'
    render "index"
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
    @title = 'Лифты облуживаемые УМ ' + @lift.node.name
    render "index"
  end

  def lifts_of_contract
    @contract  = Contract.find(params[:id])
    @lifts = @contract.lifts
    if @contract.partner.nil?
      @title = 'Лифты облуживаемые в рамках договора № ' + @contract.number
    else
      @title = 'Лифты облуживаемые в рамках договора № ' + @contract.number + ' с ' + @contract.partner.name
    end
    render "index"
  end

  def overdue_lifts
    lifts = Lift.where('introduced_at <= ?', Date.today.year - 25 ).order(:introduced_at)
    @lifts = []
    lifts.each do |l|
      if l.overhauls.empty?
        @lifts.push(l)
      else
        if l.overhauls.last.produced_at < (Date.today.year - l.overhauls.last.new_lifetime)
          @lifts.push(l)
        end
      end
    end
    @title = 'Лифты с истекшим сроком эксплуатации'
    @link_name = 'Ремонт'
    render "index"
  end

  def move
    mech = params[:mechanic_id]
    node = params[:node_id]
    if mech.nil?
      if node.nil?
      else
        @node = Node.find(params[:node_id])
        Lift.update_all(["node_id=?", params[:node_id]], :id => params[:lift_ids])
        redirect_to @node
      end
    else
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

end
