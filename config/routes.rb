Rails.application.routes.draw do

# 顧客用
  devise_for :users,skip:[:passwords],controllers:{
    registrations:"public/registrations",
    sessions:"public/sessions"
  }

  scope module: :public do
    root to: 'homes#top'
    get '/about' => 'homes#about'

    get '/word_search' => 'searchs#word_search'
    resources :tags do
      get '/search' => 'searchs#tag_search'
    end

    resources :closets do
      resources :closet_comments, only:[:create, :destroy]
      resource :favorites, only:[:create, :destroy]
    end

    resources :users, only:[:show, :index, :edit, :update] do
      resource :relationships, only:[:create, :destroy]
      member do
        get :following, :follows, :favorite
      end
    end
    get 'users/:id/closetindex' => 'users#closet_index', as:'closet_index'
    get 'users/quitcheck' => 'users#quit_check'
    patch 'users/quit' => 'users#quit'
  end



# 管理者用
  devise_for :admin,skip:[:registrations,:passwords],controllers:{
    sessions:"admin/sessions"
  }

  namespace :admin do
    root to: 'homes#top'
    get '/about' => 'homes#about'

    resources :closets, only:[:index, :show] do
      resources :closet_comments, only:[:destroy]
    # patch 'closet_comments/:id' => 'closet_comments#update', as:'admin_comment'
    end
      resources :users, only:[:index, :show]
  end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
