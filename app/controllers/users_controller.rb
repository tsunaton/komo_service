class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  # GET /users
  # GET /users.json
  def index
    @users = User.all
  end

  def show
  end

  def new
    @user = User.new
  end

  def edit
  end

  def create
    user = User.new(user_params)
    if user.save
      redirect_to '/home', notice: 'スタッフ登録完了しました！'
    else
      render '/signup'
    end
  end

  def update
    respond_to do |format|
      if @user.update(user_params)
        redirect_to @user, notice: '無事編集できました。'
      else
        render :edit
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url, notice: 'User was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params
        .require(:user)
        .permit(:name, :email, :password, :address, :possible_place)
    end
end
