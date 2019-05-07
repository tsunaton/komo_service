class Admin::PayslipsController < Admin::ApplicationController
  before_action :logged_in_user
  before_action :admin_user

  def index
  end

  def show
    @working_hours = WorkingHour.where(user_id: @current_user.id)
    @t_headers = %w(日時 会場 実働 日給 就労時間 喪家 取引先 交通費)
  end
end
