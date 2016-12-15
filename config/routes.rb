Rails.application.routes.draw do
  resources :flats do
    resources :bookings, only: [:new, :create]
  end

  resources :bookings, only: [:index, :destroy, :show, :edit, :update] do
    patch '/booking_status', to: 'bookings#requests', as: :booking_status
  end
  get '/requests', to: 'bookings#requests'


  mount Attachinary::Engine => "/attachinary"

  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  devise_for :users
  root to: 'pages#home'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
