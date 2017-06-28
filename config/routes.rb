Rails.application.routes.draw do
  get 'ajax_test/index'
  get'ajax_test/data'
  resources :followers
  root :to =>  'trends#index'
end
