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
      render :edit unless @user.update(user_params)
      if @user.user_type == "unauthenticated" && @user.update(user_type: "staff")
        redirect_to admin_users_path
      else
        render :edit
      end
  end

  def destroy
    if User.find(params[:id]).destroy
      redirect_to admin_home_path
    else
      render admin_users_path
    end
  end

  private

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params
        .require(:user)
        .permit(:name, :email, :password, :password_confirmation, :address, :available_funeral_halls, :pay_per_hour)
    end
end
