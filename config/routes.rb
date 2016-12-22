Rails.application.routes.draw do

  resources :flats do
    resources :bookings, only: [:new, :create]
  end

  resources :bookings, only: [:index, :destroy, :show, :edit, :update] do
    member do
      patch '/confirm_booking', to: 'bookings#booking_status', as: :booking_status
      patch '/cancel_booking', to: 'bookings#cancel_booking', as: :cancelled_booking
    end
  end

  get '/requests', to: 'bookings#requests'
  get '/terms', to: 'pages#terms'

  resources :suggestions, only: [:new, :create, :index, :edit, :update, :destroy]
  resources :orders, only: [:show, :create] do
      resources :payments, only: [:new, :create]
  end

  mount Attachinary::Engine => "/attachinary"

  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  devise_for :users, :controllers => { registrations: 'registrations'}
  root to: 'pages#home'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  scope '(:locale)', locale: /fr|en|it/ do
    root to: 'pages#home'
    resources :devise
  end
end
