Rails.application.routes.draw do
  
  root to: 'visitors#index'
  devise_for :users, :controllers => { registrations: 'registrations', sessions: 'sessions' }
  match 'sign_up', to: 'remote_content#sign_up', via: [:get]
  match 'sign_in', to: 'remote_content#sign_in', via: [:get]
  # resources :users
  resources :projects, only: [:new, :create, :update, :destroy] do
  	post 'update_style'
  end
end
