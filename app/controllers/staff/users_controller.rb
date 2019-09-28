class Staff::UsersController < Staff::ApplicationController
  skip_before_action :logged_out_user, only: [:new, :apply_for_authentication]

  def new
    @user = User.new
  end

  def index
  end

  def show
  end

  def edit
  end

  def create
  end

  def update
  end

  def destroy
  end

  def my_info
  end

  def apply_for_authentication
    added_user_params = user_params.merge(user_type: "unauthenticated", pay_per_hour: 0)
    @user = User.new(added_user_params)
    if @user.save
      ApplyForAuthenticationMailer.send_mail(@user).deliver_later
      redirect_to root_path, notice: "社長へ、確認メールが送信されました<br>確認が取れましたら、<br>メールでおしらせします".html_safe
    else
      render :new
    end
  end

  private

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params
        .require(:user)
        .permit(:family_name,
                :first_name,
                :email,
                :address,
                :nearest_station,
                :password,
                :password_confirmation)
    end
end
