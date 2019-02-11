class Staff::SessionsController < ApplicationController

def new
end

def create
  user = User.find_by(email: params[:session][:email])
  if user && user.authenticate(params[:session][:password])
    session[:user_id] = user.id
    remember(user)
    redirect_to '/home'
  else
    render :new
  end
end

def destroy
end

end
