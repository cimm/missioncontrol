Invoicr::Application.routes.draw do
  resources :units,   :except => [:destroy] # TODO No new acction I think
  resources :clients, :only => [:index, :new, :create]
end
