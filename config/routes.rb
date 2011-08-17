Invoicr::Application.routes.draw do
  resources :units, :except => [:destroy]
end
