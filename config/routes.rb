Rails.application.routes.draw do
  resources :flats do
    resources :bookings, only: [:new, :create]
  end

  resources :bookings, only: [:index, :destroy, :show, :edit, :update] do
    member do
    end
  end

  get '/requests', to: 'bookings#requests'
  patch '/update_status', to: 'bookings#requests', as: :booking_status


  mount Attachinary::Engine => "/attachinary"

  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  devise_for :users, :controllers => { registrations: 'registrations'}
  root to: 'pages#home'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
