class Oba::SessionsController < ApplicationController

def new
end

def create
  user = User.find_by(email: params[:email])
  if user && user.authenticate(params[:password])
    log_in(user)
    remember(user)
    redirect_to oba_home_path
  else
    render :new
  end
end

def destroy
  log_out if logged_in?
  redirect_to oba_login_path
end

end
