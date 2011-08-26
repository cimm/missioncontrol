class ClientsController < ApplicationController
  def index
    @clients = Client.all
  end

  def new
    @client = Client.new
  end

  def create
    client = Client.new(params[:client])
    client.save!
    flash[:notice] = "Client added"
    redirect_to(:action => "index")
  end

  def edit
    @client = Client.find(params[:id])
  end

  def update
    client = Client.find(params[:id])
    client.update_attributes(params[:client])
    flash[:notice] = "Client updated"
    redirect_to(:action => "index")
  end
end
