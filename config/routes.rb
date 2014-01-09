Photobooth::Application.routes.draw do
  devise_for :users, path_names: { sign_in: 'login', sign_out: 'logout' }
  root "home#index"
  resources :photos
  resources :albums
end
