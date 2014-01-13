Photobooth::Application.routes.draw do
  root "home#index"
  resources :photos, only: :create
  resources :albums, only: [:new, :create, :show]
  get '/albums', to: 'albums#index'
  get '/albums/:id/photobooth', to: 'albums#photobooth'
  devise_for :users, path_names: { sign_in: 'login', sign_out: 'logout', sign_up: 'signup' }
end
