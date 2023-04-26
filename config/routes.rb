Rails.application.routes.draw do

# 顧客用
  devise_for :users,skip:[:passwords],controllers:{
    registrations:"public/registrations",
    sessions:"public/sessions"
  }
  # ゲストユーザー
  devise_scope :user do
    post 'users/guest_sign_in' => 'public/sessions#guest_sign_in'
  end

  scope module: :public do
    root to: 'homes#top'

    get '/word_search' => 'searchs#word_search'
    get '/tag_name_search' => 'searchs#tag_name_search'
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
        get :following, :follows, :favorite, :quit_check
        patch :quit
      end
    end
    get 'users/:id/closetindex' => 'users#closet_index', as:'closet_index'
  end



# 管理者用
  devise_for :admin,skip:[:registrations,:passwords],controllers:{
    sessions:"admin/sessions"
  }

  namespace :admin do
    root to: 'homes#top'

    get '/word_search' => 'searchs#word_search'
    get '/tag_name_search' => 'searchs#tag_name_search'
    resources :tags do
      get '/search' => 'searchs#tag_search'

    end

    resources :closets, only:[:index, :show] do
      resources :closet_comments, only:[:update]
    # patch 'closet_comments/:id' => 'closet_comments#update', as:'admin_comment'
    end
    # ここ削除（destroy）
    resources :users, only:[:index, :show, :destroy] do
      member do
        get :closet_index, :following, :follows, :favorite, :quit_check
        patch :quit
      end
    end
  end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
