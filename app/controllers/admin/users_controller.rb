class Admin::UsersController < Admin::ApplicationController
  before_action :logged_in_user, only: [:show, :edit, :update, :destroy]

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
  end

  def edit
    @user = User.find(params[:id])
  end

  def create
    user = User.new(user_params)
    if user.save
      redirect_to '/staff/home', notice: 'スタッフ登録完了しました！'
    else
      render :new
    end
  end

  def update
    user = User.find(params[:id])
    if user.update(user_params)
      redirect_to admin_users_path
    else
      render :edit
    end
  end

  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url, notice: 'User was successfully destroyed.' }
      format.json { head :no_content }
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
