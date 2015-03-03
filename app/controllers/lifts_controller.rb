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
    store_location
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
    store_location
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
    respond_to do |format|
      format.html
      format.xls # { render text: @lifts.to_csv }
    end
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
    @lifts = Lift.overdue_lifts
    @title = 'Лифты с истекшим сроком эксплуатации'
    @link_name = 'Ремонт'
    render "index"
  end

  def move
    mech     = params[:mechanic_id]
    node     = params[:node_id]
    contract = params[:contract_id]
    tlr      = params[:tlr_id]
    if mech.nil?
      if node.nil?
        if contract.nil?
          if tlr.nil?
          else
            @tlr = Tlr.find(params[:tlr_id])
            Lift.update_all(["tlr_id=?", params[:tlr_id]], :id => params[:lift_ids])
            redirect_back_or_default(store_location)
          end
        else
          @contract = Contract.find(params[:contract_id])
          Lift.update_all(["contract_id=?", params[:contract_id]], :id => params[:lift_ids])
          redirect_back_or_default(store_location)
        end
      else
        @node = Node.find(params[:node_id])
        Lift.update_all(["node_id=?", params[:node_id]], :id => params[:lift_ids])
        redirect_back_or_default(store_location)
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
      redirect_back_or_default(store_location)
    end
  end

  def select_price
    session[:return_to] ||= request.referer
    prices = Price.all
    prices.each do |p|
      case p.floor
        when 1
          @pricesnull = [] if @pricesnull.nil?
          @pricesnull.push(p)
        when 2
          @prices2fl = [] if @prices2fl.nil?
          @prices2fl.push(p)
        when 3
          @prices3fl = [] if @prices3fl.nil?
          @prices3fl.push(p)
        when 4
          @prices4fl = [] if @prices4fl.nil?
          @prices4fl.push(p)
        when 5
          @prices5fl = [] if @prices5fl.nil?
          @prices5fl.push(p)
        when 6
          @prices6fl = [] if @prices6fl.nil?
          @prices6fl.push(p)
        when 7
          @prices7fl = [] if @prices7fl.nil?
          @prices7fl.push(p)
        when 8
          @prices8fl = [] if @prices8fl.nil?
          @prices8fl.push(p)
        when 9
          @prices9fl = [] if @prices9fl.nil?
          @prices9fl.push(p)
        when 10
          @prices10fl = [] if @prices10fl.nil?
          @prices10fl.push(p)
        when 11
          @prices11fl = [] if @prices11fl.nil?
          @prices11fl.push(p)
        when 12
          @prices12fl = [] if @prices12fl.nil?
          @prices12fl.push(p)
        when 13
          @prices13fl = [] if @prices13fl.nil?
          @prices13fl.push(p)
        when 14
          @prices14fl = [] if @prices14fl.nil?
          @prices14fl.push(p)
        when 15
          @prices15fl = [] if @prices15fl.nil?
          @prices15fl.push(p)
        when 16
          @prices16fl = [] if @prices16fl.nil?
          @prices16fl.push(p)
        when 17
          @prices17fl = [] if @prices17fl.nil?
          @prices17fl.push(p)
        else
      end
    end
    @lift   = Lift.find(params[:id])
    @porch  = @lift.porch
    @build  = @porch.build
    @street = @build.street
  end

  def select_price_save
    @lift   = Lift.find(params[:id])
    @lift.price_id = params[:price_id]
    if @lift.save
      flash[:success] = "Лифт с регистрационным номером: " + @lift.regnum + " обновлен"
      redirect_to session.delete(:return_to)
    else
      render 'select_price_save'
    end
  end

  def select_price_cancel
    redirect_to session.delete(:return_to)
  end

end