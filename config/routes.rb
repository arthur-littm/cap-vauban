Rails.application.routes.draw do
  resources :flats, only: [:index, :show]

  get 'booking/index'

  get 'booking/show'

  get 'booking/edit'

  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  devise_for :users
  root to: 'pages#home'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
