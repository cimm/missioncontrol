class ClientsController < ApplicationController
  def index
    @clients = Client.all
  end

  def new
    @client = Client.new
  end

  def create
    @client = Client.new(params[:client])
    if @client.save
      redirect_to clients_path, :notice => "Client added"
    else
      flash[:error] = "Client not added"
      render :new
    end
  end

  def edit
    @client           = Client.find(params[:id])
    @vat_number_valid = @client.has_valid_vat_number?
  end

  def update
    client = Client.find(params[:id])
    client.update_attributes(params[:client])
    flash[:notice] = "Client updated"
    redirect_to(:action => "index")
  end
end
