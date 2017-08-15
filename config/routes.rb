Rails.application.routes.draw do

  root to: "top#index"
  resources :followers, only: [:index, :create]
  get '/followers/destroy_handle/:handle_id', to:'followers#destroy_handle', as: :destroy_handle
  get '/followers/export_csv', to:'followers#export_csv', as: :export_csv
  get '/followers/search', to:'followers#search', as: :search
  get '/trends', to:'trends#index'
  get '/trends/history', to: 'trends#history', as: :history
  resources :types, only: [:destroy, :create]
end
