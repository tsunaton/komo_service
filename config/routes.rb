Rails.application.routes.draw do




  namespace :staff do

    get '/signup',  to: 'users#new'
    post '/signup'  => 'users#create'

    get    '/login',   to: 'sessions#new'
    post   '/login'   => 'sessions#create'

    delete '/logout'  => 'sessions#destroy'

    get    '/home',   to: 'static_pages#home'
    
    get     '/payslip',  to:'documents#payslip'

    resources :users

    resources :places, :except => [:show]

    resources :clients, :except => [:show]

    resources :machings

    resources :working_hours, :only => [:new, :create, :edit, :update, :destroy]

    resources :shifts

  end


  namespace :oba do

    get    '/home',   to: 'static_pages#home'
    get     '/payslip',  to:'static_pages#payslip'

    resources :users

    resources :places, :except => [:show]

    resources :clients, :except => [:show]

    resources :works

    get '/temp', to: 'works#temp'

    resources :machings

    get   '/search_page',  to: 'searchings#search_page'
    get   '/searching',  to: 'searchings#searching'

    resources :working_hours, :only => [:new, :create, :edit, :update, :destroy]

  end

end
