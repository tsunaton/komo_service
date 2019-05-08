class WorkAcceptanceMailer < ApplicationMailer
  default from: 'urusei_suika@yahoo.co.jp'

  def send_mail
    @user = User.first
    @funeral = Funeral.first
    @url = Settings.url % @working_hour.id
    mail(to: @user.email, subject: 'お仕事依頼がきました')
  end
end
