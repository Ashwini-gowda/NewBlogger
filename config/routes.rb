Rails.application.routes.draw do
  resources :user_roles
  devise_for :users, :controllers => { sessions: 'users/sessions', passwords: 'users/passwords' }
  resources :users

  resources :sub_categories
  resources :categories
  #resources :comments

  resources :articles do
    get :auto_suggest, on: :collection
    resources :comments  
  end

  resources :comments do
    post :reply, on: :member
    resources :comments
  end

  root to: "users#index"
end
