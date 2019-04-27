Rails.application.routes.draw do
  mount Ckeditor::Engine => '/ckeditor'
  devise_for :users
  get 'likes/update'
  root 'blogs#index'
  resources :blogs do
    resources :comments, only: [:create, :destroy]
  end
  resources :tests, only: [:index]
  namespace :admin do
    root 'blogs#index'
    resources :blogs, except: [:show]
    resources :comments, except: [:show]
    resources :users, except: [:show]
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
