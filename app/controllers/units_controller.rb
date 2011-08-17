class UnitsController < ApplicationController
  def index
    @unit        = Unit.new
    @units       = Unit.all
    @total_units = @units.count
  end

  def create
    unit = Unit.new(params[:unit])
    unit.save!
    flash[:notice] = "Unit added"
    redirect_to(:action => "index")
  end

  def edit
    @unit = Unit.find(params[:id])
  end

  def update
    unit = Unit.find(params[:id])
    unit.update_attributes(params[:unit])
    flash[:notice] = "Unit updated"
    redirect_to(:action => "index")
  end
end
