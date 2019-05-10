class WorkAcceptanceMailer < ApplicationMailer

  def send_mail(user, funeral, working_hour)
    @user = user
    @funeral = funeral
    @url = Settings.work_accept.url % working_hour.id
    mail(from: Settings.work_accept.mail_from, to: @user.email, subject: 'お仕事依頼がきました')
  end
end
