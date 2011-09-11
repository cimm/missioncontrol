class UnitsController < ApplicationController
  def index
    @units       = Unit.all
    @projects    = Project.all
    @total_units = @units.count
  end

  def new
    @unit              = Unit.new
    @projects          = Project.all
    flash.now[:notice] = "Create a project first" if @projects.empty?
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
    @unit     = Unit.find(params[:id])
    @projects = Project.all
  end

  def update
    unit = Unit.find(params[:id])
    unit.update_attributes(params[:unit])
    flash[:notice] = "Unit updated"
    redirect_to(:action => "index")
  end
end
