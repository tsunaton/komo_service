Rails.application.routes.draw do

  #新規登録
  get '/signup',  to: 'users#new'
  post '/signup'  => 'users#new'

  #ログイン
  get    '/login',   to: 'sessions#new'
  post   '/login'   => 'sessions#create'

  #ログアウト
  delete 'logout'  => 'sessions#destroy'

  #ホームへ
  get    '/home',   to: 'static_pages#home'

  #スタッフ一覧/index
  #スタッフ詳細/show
  #スタッフ情報編集/edit**komo
  #スタッフ情報削除/destroy**komo
  resources :users
  #会場一覧
  #会場詳細
  # resources :places
  #取引先一覧
  #取引先詳細
  # resources :clients




  #案件詳細



  namespace :staff do
  get    '/home',   to: 'static_pages#home'

  #   スタッフホーム
  #
    resources :shifts
  #
  #   過去のお仕事一覧
  #
  #   給与明細
  #
  #   終了報告１
  #   終了報告２
  end
  #
  namespace :oba do
  get    '/home',   to: 'static_pages#home'
  #   こもホーム
  #
  #   案件入力１
  #   案件入力２
  #   案件入力３
  #   再案件入力
  #
  #   給与明細
  #   請求書
  #
  #   遅刻処理１
  #   遅刻処理２
  #   遅刻処理３
  #
  #   カレンダー
  end

end
