Rails.application.routes.draw do

  #新規登録
  get '/signup',  to: 'users#new'
  post '/signup'  => 'users#new'

  #スタッフ一覧/index
  #スタッフ詳細/show
  #スタッフ情報編集/edit**komo
  #スタッフ情報削除/destroy**komo
  resources :users

  #会場一連
  resources :places, :only => [:index, :new, :create, :edit, :update, :destroy]

  #取引先一連
  resources :clients, :only => [:index, :new, :create, :edit, :update, :destroy]

  #給与明細 > static_pages#payslip
  get     '/payslip',  to:'static_pages#payslip'


  namespace :staff do

    #ログイン
    get    '/login',   to: 'sessions#new'
    post   '/login'   => 'sessions#create'

    #ログアウト
    delete '/logout'  => 'sessions#destroy'

    #ホーム
    get    '/home',   to: 'static_pages#home'

    #終了報告一連
    resources :working_hours, :only => [:new, :create, :edit, :update, :destroy]

    #シフト
    resources :shifts

  end


  namespace :oba do

    #ログイン
    get    '/login',   to: 'sessions#new'
    post   '/login'   => 'sessions#create'

    #ログアウト
    delete 'logout'  => 'sessions#destroy'

    #ホーム
    get    '/home',   to: 'static_pages#home'

    #案件入力一連
    resources :works, :only => [:new, :create, :edit, :update, :destroy]

  end

end
