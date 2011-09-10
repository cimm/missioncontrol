class PreferencesController < ApplicationController
  def index
    @preferences = Preference.all
  end

  def edit
    @preference = Preference.find(params[:id])
  end

  def update
    preference = Preference.find(params[:id])
    preference.update_attributes(params[:preference])
    flash[:notice] = "Preference updated"
    redirect_to(:action => "index")
  end
end
