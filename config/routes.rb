Photobooth::Application.routes.draw do
  root 'home#index'

  resources :albums
  resources :photos, only: :create

  get '/albums/:id/photobooth', to: 'albums#photobooth'

  devise_for :users, path_names: {
    sign_in: 'login',
    sign_out: 'logout',
    sign_up: 'signup'
  }
end
