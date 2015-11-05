Stukbook::Application.routes.draw do
  devise_for :users, controllers: {registrations: 'registrations'}
  root 'pages#home'
  resources :users, only: [:show, :index]

end
