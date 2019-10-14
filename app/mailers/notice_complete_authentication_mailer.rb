class NoticeCompleteAuthenticationMailer < ApplicationMailer
  def send_mail(user)
  	@user = user
    @url = Settings.notice_complete_authentication.url
  	mail(from: Settings.notice_complete_authentication.mail_from,
         to: @user.email,
         subject: "スタッフ承認が完了しました" )
  end
end
