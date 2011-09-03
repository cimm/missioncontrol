class ProjectsController < ApplicationController
  def index
    @projects = Project.all
  end

  def new
    @project = Project.new
    @clients = Client.all
  end

  def create
    @project = Project.new(params[:project])
    if @project.save
      redirect_to projects_path, :notice => "Project added"
    else
      flash[:error] = "Project not added"
      render :new
    end
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
