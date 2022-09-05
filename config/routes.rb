Rails.application.routes.draw do

  devise_for :users,skip: [:passwords], controllers: {
  registrations: "public/registrations",
  sessions: 'public/sessions'
  }

  scope module: :public do
   post '/guests/guest_sign_in', to: 'guests#new_guest'
   root 'homes#top'
   get '/users/:id/unsubscribe' => 'users#unsubscribe', as: 'unsubscribe'
   patch '/users/:id/withdrawal' => 'users#withdrawal', as: 'withdrawal'
   get "search_tag" => "articles#search_tag"


   resources :users, only: [:show, :edit, :update]
   resources :articles do
      collection do
        get 'search'
      end
    end
   resources :article_tags
   resources :tags
   resources :comments
   resources :bookmarks

  end

  devise_for :admins, skip: [:registrations, :passwords], controllers: {
  sessions: "admin/sessions"
  }
  
  
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
