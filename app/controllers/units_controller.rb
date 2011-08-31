class UnitsController < ApplicationController
  def index
    @unit        = Unit.new
    @units       = Unit.all
    @clients     = Client.all
    @total_units = @units.count
  end

  def create
    unit = Unit.new(params[:unit])
    if unit.save
      flash[:notice] = "Unit added"
    else
      flash[:error] = "Unit not added"
    end
    redirect_to(:action => "index")
  end

  def edit
    @unit    = Unit.find(params[:id])
    @clients = Client.all
  end

  def update
    unit = Unit.find(params[:id])
    unit.update_attributes(params[:unit])
    flash[:notice] = "Unit updated"
    redirect_to(:action => "index")
  end
end
