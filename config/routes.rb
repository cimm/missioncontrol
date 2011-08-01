Invoicr::Application.routes.draw do
  resources :units, :only => [:index, :create]
end
