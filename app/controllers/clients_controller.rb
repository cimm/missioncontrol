class ClientsController < ApplicationController
  def new
    @client = Client.new
  end

  def create
    client = Client.new(params[:client])
    client.save!
    flash[:notice] = "Client added"
    redirect_to(:action => "index")
  end
end
