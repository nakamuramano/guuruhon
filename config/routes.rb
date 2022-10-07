Rails.application.routes.draw do
  devise_for :users,skip: [:passwords], controllers: {
  registrations: "public/registrations",
  sessions: 'public/sessions'
  }

  scope module: :public do
   post '/guests/guest_sign_in', to: 'guests#new_guest'
   root 'homes#top'
   get "homes/about" => "homes#about"
   get '/users/:id/unsubscribe' => 'users#unsubscribe', as: 'unsubscribe'
   patch '/users/:id/withdrawal' => 'users#withdrawal', as: 'withdrawal'
   get "search_tag" => "articles#search_tag"
   get 'users/:id/rank' => 'users#rank', as: 'rank'


   resources :users, only: [:show, :edit, :update]
   resources :articles do
     resource :bookmarks, only: [:create, :destroy]
      collection do
        get 'search'
      end
      resources :comments, only: [:create, :destroy]
    end
   resources :article_tags
   resources :tags
   resources :bookmarks, only: [:index]
   resources :books

  end

  devise_for :admins, skip: [:registrations, :passwords], controllers: {
  sessions: "admin/sessions",
  }

   namespace :admin do

   get 'users/:id/unsubscribe' => 'users#unsubscribe', as: 'unsubscribe'
   patch 'users/:id/withdrawal' => 'users#withdrawal', as: 'withdrawal'
   get "search_tag" => "articles#search_tag"
   post '/guests/guest_sign_in', to: 'guests#new_guest'
   get 'users/:id/bookmark' => 'users#bookmark', as: 'bookmark'
   get 'users/:id/rank' => 'users#rank', as: 'rank'
   get 'books/search' => 'books#search'

   resources :articles do
       resource :bookmarks, only: [:create, :destroy]
        collection do
          get 'search'
        end
       resources :comments, only: [:create, :destroy]
     end
   resources :tags
   resources :users
  end


  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
