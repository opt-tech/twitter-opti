Rails.application.routes.draw do
  get 'top/index'
  root to: "top#index"
  resources :followers
  get '/trends', to:'trends#index'
  get '/trends/history', to: 'trends#history', as: :history
end
