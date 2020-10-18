Rails.application.routes.draw do
  # 順番を入れ替え
  devise_for :users
  resources :users, only: [:show,:index,:edit,:update]
  resources :books do
    resource :favorite, only: [:create, :destroy]
    resources :book_comments, only: [:create, :destroy]
  end

  root 'homes#top'
  get 'home/about' => 'homes#about', as: 'about'
# endを追加
end