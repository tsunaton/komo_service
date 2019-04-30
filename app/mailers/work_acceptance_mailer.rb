class WorkAcceptanceMailer < ApplicationMailer
  default from: 'urusei_suika@yahoo.co.jp'

  def send_mail
    @user = User.first
    @url  = 'localhost:3000'
    mail(to: @user.email, subject: '私の素敵なサイトへようこそ')
  end
end
