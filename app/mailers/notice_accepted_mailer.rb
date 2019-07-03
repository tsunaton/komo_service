class NoticeAcceptedMailer < ApplicationMailer
  def send_mail(user, working_hour)
  	@user = user
  	@work = working_hour
  	@users = User.where(id: @work.funeral.working_hours).reject{ |u| u == @user || u.user_type == "admin" }
  	mail(from: Settings.apply_for_authentication.mail_from,#apply_for_authenticationと同じ
         to: Settings.apply_for_authentication.mail_to,#apply_for_authenticationと同じ
         subject: "#{@user.name}さんがお仕事を承認しました" )
  end
end
