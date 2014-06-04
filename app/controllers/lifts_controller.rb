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
 
end
