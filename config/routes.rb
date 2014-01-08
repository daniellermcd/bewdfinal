Photobooth::Application.routes.draw do
  devise_for :users
  root "home#index"
  resources :photos
  resources :albums
end
