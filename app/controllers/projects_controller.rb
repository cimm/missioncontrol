class ProjectsController < ApplicationController
  def index
    @projects = Project.all
  end

  def new
    @project           = Project.new
    @clients           = Client.all
    flash.now[:notice] = "Create a client first" if @clients.empty?
  end

  def create
    project = Project.new(params[:project])
    if project.save
      flash[:notice] = "Project added"
    else
      flash[:error] = "Project not added"
    end
    redirect_to(:action => "index")
  end

  def edit
    @project = Project.find(params[:id])
    @clients = Client.all
  end

  def update
    project = Project.find(params[:id])
    project.update_attributes(params[:project])
    flash[:notice] = "Project updated"
    redirect_to(:action => "index")
  end
end
