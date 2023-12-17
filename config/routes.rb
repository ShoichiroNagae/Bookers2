Rails.application.routes.draw do
  devise_for :users
  root to: 'homes#top'
  get '/home/about' => "homes#about", as:"about"
  get '/' => 'homes#top'
  resources :users, only:[:show, :edit, :index, :update]
  resources :books, only:[:new, :index, :edit, :show, :create,:update, :destroy]

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
