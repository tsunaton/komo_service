Rails.application.routes.draw do

  root 'sessions#new'
  post   '/login'   => 'sessions#create'
  delete '/logout'  => 'sessions#destroy'

  namespace :staff do

    get '/signup',  to: 'users#new'
    post '/apply_for_authentication'  => 'users#apply_for_authentication'

    get    '/home',   to: 'homes#home'

    resources :users

    resources :funeral_halls, :except => [:show]

    resources :clients, :except => [:show]

    resources :working_hours

    resources :shifts

    resources :payslips, :only => [:show]

  end


  namespace :admin do

    get    '/home',   to: 'homes#home'

    get    '/authenticate_staff', to: 'users#authenticate_staff'
    resources :users

    resources :funeral_halls, :except => [:show]

    resources :clients, :except => [:show]

    resources :funerals

    get   '/search_page',  to: 'funerals#search_page'
    get   '/search',  to: 'funerals#search'

    resources :working_hours, :only => [:new, :create, :edit, :update, :destroy]

    resources :payslips, :only => [:index, :show, :edit, :update]

    resources :invoices, :only => [:index, :show, :edit, :update]

  end

end
