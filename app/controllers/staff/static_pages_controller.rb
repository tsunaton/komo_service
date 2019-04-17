class Staff::StaticPagesController < Staff::Base
before_action :logged_in_user

  def home
  end

end
