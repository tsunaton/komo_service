class Admin::UsersController < Admin::ApplicationController

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
  end

  def edit
    @user = User.find(params[:id])
  end

  def create
  end

  def update
    @user = User.find(params[:id])
    case @user.user_type
    when "unauthenticated"
      if @user.update(user_params.merge(user_type: "staff"))
        redirect_to admin_users_path
      else
        render :staff_authentication
      end
    when "staff"
      if @user.update(user_params)
        redirect_to admin_users_path
      else
        render :edit
      end
    end
  end

  def destroy
    if User.find(params[:id]).destroy
      redirect_to admin_home_path
    else
      render admin_users_path
    end
  end

  def staff_authentication
    @user = User.find(params[:id])
    redirect_to admin_users_path unless @user.user_type == "unauthenticated"
  end

  private

    def user_params
      params
        .require(:user)
        .permit(:pay_per_hour)
    end

end
