MissionControl::Application.routes.draw do
  resources :units,       :except => [:show, :destroy]
  resources :clients,     :except => [:show, :destroy]
  resources :projects,    :except => [:show, :destroy]
  resources :preferences, :only   => [:index, :edit, :update]
  root :to => 'units#index'
end
