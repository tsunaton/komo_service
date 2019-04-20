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

    resources :places, :except => [:show]

    resources :clients, :except => [:show]

    resources :machings

    resources :working_hours, :only => [:new, :create, :edit, :update, :destroy]

    resources :shifts

  end


  namespace :admin do

    get    '/home',   to: 'static_pages#home'
    get     '/payslip',  to:'static_pages#payslip'

    resources :users

    resources :places, :except => [:show]

    resources :clients, :except => [:show]

    resources :works

    get   '/search_page',  to: 'works#search_page'
    get   '/search',  to: 'works#search'

    resources :machings

    resources :working_hours, :only => [:new, :create, :edit, :update, :destroy]

  end

end
