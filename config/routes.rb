Rails.application.routes.draw do

  root 'staff/sessions#new'

  namespace :staff do

    get '/signup',  to: 'users#new'
    post '/signup'  => 'users#create'


    post   '/login'   => 'sessions#create'

    delete '/logout'  => 'sessions#destroy'

    get    '/home',   to: 'static_pages#home'

    get     '/payslip',  to:'documents#payslip'

    resources :users

    resources :funeral_hallss, :except => [:show]

    resources :clients, :except => [:show]

    resources :machings

    resources :working_hours, :only => [:new, :create, :edit, :update, :destroy]

    resources :shifts

  end


  namespace :admin do

    get    '/home',   to: 'static_pages#home'
    get     '/payslip',  to:'static_pages#payslip'

    resources :users

    resources :funeral_hallss, :except => [:show]

    resources :clients, :except => [:show]

    resources :funerals

    get   '/search_page',  to: 'funerals#search_page'
    get   '/search',  to: 'funerals#search'

    resources :machings

    resources :working_hours, :only => [:new, :create, :edit, :update, :destroy]

  end

end
