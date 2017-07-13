Rails.application.routes.draw do
  get 'top/index'
  root to: "top#index"
  resources :followers, only: [:index, :create]
  get '/trends', to:'trends#index'
  get '/trends/history', to: 'trends#history', as: :history
end
