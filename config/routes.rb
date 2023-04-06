Rails.application.routes.draw do

# 顧客用
  devise_for :users,skip:[:passwords],controllers:{
    registrations:"public/registrations",
    sessions:"public/sessions"
  }

  scope module: :public do
    root to: 'homes#top'
    get '/about' => 'homes#about'

    resources :closets do
      resources :tags, only:[:new, :create, :destroy]
    end

    resources :users, only:[:show, :edit, :update]
    get 'users/:id/closetindex' => 'users#closet_index', as:'closet_index'
    get 'users/quitcheck' => 'users#quit_check'
    patch 'users/quit' => 'users#quit'
  end


# 管理者用
  devise_for :admin,skip:[:registrations,:passwords],controllers:{
    sessions:"admin/sessions"
  }

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
