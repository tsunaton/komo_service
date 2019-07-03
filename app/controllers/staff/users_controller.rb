class Staff::UsersController < Staff::ApplicationController
  before_action :logged_out_user, only: [:new, :create]
  
  def new
    @user = User.new
  end

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
      redirect_to edit_admin_user_path
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

  def apply_for_authentication
    added_user_params = user_params.merge(user_type: "unauthenticated", pay_per_hour: 0)
    @user = User.new(added_user_params)
    if @user.save
      ApplyForAuthenticationMailer.send_mail(@user).deliver_later
      redirect_to root_path
    else
      render :new
    end
  end

  private

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params
        .require(:user)
        .permit(:name,
                :email,
                :address,
                :nearest_station,
                :password,
                :password_confirmation)
    end
end
