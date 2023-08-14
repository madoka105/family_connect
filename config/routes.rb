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

    resources :users, only: [:index, :show, :edit, :update]
    # 会員（一覧、詳細、編集、情報の更新）

    resources :posts, only: [:show, :index, :destroy]
    # 投稿（詳細、一覧、削除）

  end


# 顧客用
# URL /users/sign_in ...

  devise_scope :user do
    post "users/guest_sign_in", to: "user/sessions#guest_sign_in"
  end



    scope module: :public do

    root to: 'homes#top'
    get "/homes/about" => "homes#about", as: "about"

    get 'users/mypage' => 'users#show'
    # 顧客のマイページ

    get 'users/information/edit' => 'users#edit'
    # 顧客の会員登録情報編集

    patch 'users/information/update' => 'users#update'
    # 顧客の登録情報更新

    get 'users/check' => 'users#check', as: 'users_check'
    # 顧客の退会確認画面

    get 'users/withdrawal' => 'users#withdrawal', as: 'users_withdrawal'
    # 顧客の退会処理(ステータスの更新)

    resources :comments, only: [:create, :destroy]
    # コメント（送信、削除）

    resources :chats, only: [:create, :destroy, :index, :show]
    # チャット（送信、削除）

    resources :chat_rooms, only: [:show, :create, :index]
    # チャットルーム（画面、作成、一覧）

    resources :seaches, only: [:search]
    # 検索（キーワードで投稿検索、会員検索）

    resources :favorites, only: [:index, :destroy, :create]
    # いいね（一覧、削除、追加）

    resources :relationships, only: [:create, :destroy]
    # フォロー（フォローする、削除）

    get 'relationships/followed' => 'relationships#followed'
    # フォロー一覧

    get 'relationships/followers' => 'relationships"followers'
    # フォロワー一覧

    resources :posts, only: [:index, :new, :create, :show, :destroy]
    # 投稿（一覧、新規作成画面、作成、詳細、削除）

  end


  # root to: 'homes#top'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
