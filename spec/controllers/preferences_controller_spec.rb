require "spec_helper"

describe PreferencesController do
  let(:preference) { mock("Preference") }

  describe "index" do
    let(:preferences) { [mock("Preference")] }

    before :each do
      Preference.stub(:all => preferences)
    end

    it "gets all the preferences" do
      Preference.should_receive(:all)
      get :index
    end

    it "assigns all the preferences" do
      get :index
      assigns(:preferences).should eql preferences
    end
  end

  describe "edit" do
    let(:preference_id) { "Id for the edited preference" }

    before :each do
      Preference.stub(:find => preference)
    end

    it "gets the preference to edit" do
      Preference.should_receive(:find).with(preference_id)
      get :edit, :id => preference_id
    end

    it "assigns the preference" do
      get :edit, :id => preference_id
      assigns(:preference).should eql preference
    end

    it "renders the edit page" do
      get :edit, :id => preference_id
      response.should render_template(:edit)
    end
  end

  describe "update" do
    let(:preference_id) { "Id for the updated preference" }
    let(:params)        { {} }

    before :each do
      Preference.stub(:find => preference)
      preference.stub(:update_attributes)
    end

    it "gets the preference to update" do
      Preference.should_receive(:find).with(preference_id)
      put :update, :id => preference_id, :preference => params
    end

    it "updates and persists the preference" do
      preference.should_receive(:update_attributes).with(params)
      put :update, :id => preference_id, :preference => params
    end

    it "assigns a flash message" do
      put :update, :id => preference_id, :preference => params
      flash[:notice].should_not be_nil
    end

    it "redirects to the preferences index page" do
      put :update, :id => preference_id, :preference => params
      response.should redirect_to(:action => "index")
    end
  end
end
