class UnitsController < ApplicationController
  def index
    @unit        = Unit.new
    @total_units = Unit.count
  end

  def create
    unit = Unit.new
    unit.save!
    flash[:notice] = "Unit added"
    redirect_to(:action => "index")
  end
end
