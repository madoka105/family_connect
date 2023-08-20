Rails.application.routes.draw do

# 顧客用
# URL /users/sign_in ...
  devise_for :users,skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: 'public/sessions',
    passwords: 'users/passwords'
  }
  # 管理者用
  # URL /admin/sign_in ...
  devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
    sessions: "admin/sessions"
  }
  namespace :admin do
    root to: 'homes#top'
    # 会員（一覧、詳細、編集、情報の更新）
    resources :users, only: [:index, :show, :edit, :update]

    # 投稿（詳細、一覧、削除）
    resources :posts, only: [:show, :index, :destroy]

    # 検索（キーワードで会員検索）
    get "search" => "searches#search"

  end

  # 顧客用
  # URL /users/sign_in ...
  devise_scope :user do
    post "users/guest_sign_in", to: "user/sessions#guest_sign_in"
  end

  scope module: :public do
    root to: 'homes#top'
    get "/homes/about" => "homes#about", as: "about"
    # 顧客のマイページ
    get 'users/mypage' => 'users#show'

    # 顧客の会員登録情報編集
    get 'users/information/edit' => 'users#edit'

    # 顧客の登録情報更新
    patch 'users/information/update' => 'users#update'

    # 顧客の退会確認画面
    get 'users/check' => 'users#check', as: 'users_check'

    # 顧客の退会処理(ステータスの更新)
    get 'users/withdrawal' => 'users#withdrawal', as: 'users_withdrawal'

    # コメント（送信、削除）
    resources :comments, only: [:create, :destroy]

    # チャット（送信、削除）
    resources :chats, only: [:create, :destroy, :index, :show]

    # チャットルーム（画面、作成、一覧）
    resources :chat_rooms, only: [:show, :create, :index]

    # 検索（キーワードで投稿検索）
    get "search" => "searches#search"

    # 通知機能、全削除
    resources :notifications, only: [:index, :destroy]

    resources :users, only: [:index, :show, :edit, :update] do
      member do
        get :follows, :followers
      end
      resource :relationships, only: [:create, :destroy]
    end

    # いいね機能
    get 'favorites' => 'favorites#index', as: "favorites"

     # フォロー一覧
    get 'followings' => 'relationships#followings', as: "followings"

    # フォロワー一覧
    get 'followers' => 'relationships#followers', as: "followers"

    resources :post_images, only: [:new, :create, :index, :show, :destroy] do

    end

    # get 'user' => 'users#index'

    # 投稿（一覧、新規作成画面、作成、詳細、削除）
    
    resources :posts, only: [:index, :new, :create, :show, :destroy] do
      #投稿のコメント(作成、削除)
       resources :post_comments, only: [:create, :destroy]

      # いいね（一覧、削除、追加）
      resource :favorites, only: [:index, :destroy, :create]

    end
  end
end