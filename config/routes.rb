Invoicr::Application.routes.draw do
  resources :units,   :except => [:new, :destroy]
  resources :clients, :only => [:index, :new, :create]
end
