Rails.application.routes.draw do

  "mount Ckeditor::Engine => '/ckeditor'"

  devise_for :users, :controllers => { :registrations => "registrations" }
  as :user do
    get "/register", to: "registrations#new", as: "register"
  end
  resources :users
  resources :user_roles
  
  
  resources :categories
  resources :sub_categories

  resources :articles do
    get :auto_suggest, on: :collection
    resources :sub_categories
    resources :comments, :only => [:create] 
  end

  resources :comments do
    #post :reply, on: :member
    resources :comments
  end

  root to: "users#index"
end
