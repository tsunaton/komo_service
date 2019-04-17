class Staff::WorkingHoursController < Staff::Base
before_action :set_user, only: [:show, :edit, :update, :destroy]

  #終了報告
  def new
  end

  def create
  end

  #遅刻処理
  def edit
  end

  def update
  end

  #間違ったとき削除
  def destroy
  end


end
