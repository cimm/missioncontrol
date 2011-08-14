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
end
