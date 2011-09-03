Invoicr::Application.routes.draw do
  resources :units,    :except => [:new, :destroy]
  resources :clients,  :except => [:show, :destroy]
  resources :projects, :except => [:show, :destroy]
end
