class Staff::StaticPagesController < Staff::ApplicationController
before_action :logged_in_user

  def home
  end

end
