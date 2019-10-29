Rails.application.routes.draw do

  root 'sessions#new'
  post   '/login'   => 'sessions#create'
  delete '/logout'  => 'sessions#destroy'

  namespace :staff do

    get '/signup',  to: 'users#new'
    post '/apply_for_authentication'  => 'users#apply_for_authentication'

    get    '/home',   to: 'homes#home'

    get '/my_info', to: 'users#my_info'
    resources :users

    resources :funeral_halls, :except => [:show]

    resources :clients, :except => [:show]

    get '/modification_report', to: 'working_hours#modification_report'
    post '/send_modification_report'  => 'working_hours#send_modification_report'
    get '/form_transportation_fee'  => 'working_hours#form_transportation_fee'
    patch '/update_transportation_fee'  => 'working_hours#update_transportation_fee'
    post '/modify_working_hour', to: 'working_hours#modify_working_hour'
    post '/end_report', to: 'working_hours#end_report'
    post '/accept_or_reject', to: 'working_hours#accept_or_reject'
    resources :working_hours

    resources :shifts

    resources :payslips, :only => [:show]

  end


  namespace :admin do

    get    '/home',   to: 'homes#home'

    resources :users
    get    '/users/:id/staff_authentication',   to: 'users#staff_authentication', as: 'staff_authentication'

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
