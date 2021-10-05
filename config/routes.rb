Rails.application.routes.draw do
   devise_for :users

  root to: 'homes#top'
  get 'home/about' => 'homes#about'

   resources :users do
    get 'followings' => 'relationships#followings', as: 'followings'
    get 'followers' => 'relationships#followers', as: 'followers'
    resource :relationships,only:[:create,:destroy]
    end
  resources :books do
    resources :book_comments, only: [:create, :destroy]
     resource :favorites,only: [:create,:destroy]
    end
end