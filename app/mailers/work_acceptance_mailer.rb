class WorkAcceptanceMailer < ApplicationMailer
  default from: 'urusei_suika@yahoo.co.jp'

  def send_mail
    @user = User.first
    @funeral = Funeral.first
    @url = 'https://komo-service-staging.herokuapp.com/'
    mail(to: @user.email, subject: 'お仕事依頼がきました')
  end
end
