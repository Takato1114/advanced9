Rails.application.routes.draw do
  get 'rooms/show'
  # 順番を入れ替え
  devise_for :users, :controllers => {
    :registrations => 'users/registrations'
   }
  resources :users, only: [:show,:index,:edit,:update]
  resources :books do
    resource :favorite, only: [:create, :destroy]
    resources :book_comments, only: [:create, :destroy]
  end
  resources :chats, only: [:create]
  resources :rooms, only: [:create, :show]


  post 'follow/:id' => 'relationships#create', as: 'follow'
  post 'unfollow/:id' => 'relationships#destroy', as: 'unfollow'

  get 'follows/:id' => 'users#following', as: 'follows'
  get 'followers/:id' => 'users#follower', as: 'followers'

  get 'search' => 'search#search', as: 'search'

  root 'homes#top'
  get 'home/about' => 'homes#about', as: 'about'
# endを追加
end