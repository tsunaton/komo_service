Rails.application.routes.draw do

  root 'staff/sessions#new'
  post   '/login'   => 'sessions#create'
  delete '/logout'  => 'sessions#destroy'

  namespace :staff do

    get '/signup',  to: 'users#new'
    post '/signup'  => 'users#create'

    get    '/home',   to: 'static_pages#home'

    get     '/payslip',  to:'documents#payslip'

    resources :users

    resources :funeral_halls, :except => [:show]

    resources :clients, :except => [:show]

    resources :working_hours

    resources :shifts

  end


  namespace :admin do

    get    '/home',   to: 'static_pages#home'

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
