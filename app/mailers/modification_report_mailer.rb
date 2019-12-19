class ModificationReportMailer < ApplicationMailer
  def send_mail(user, funeral, end_time, content)
    @user_name = user.family_name + user.first_name
    @start_time = funeral.start_time.&.strftime("%Y年%m月%d日 %H:%M")
    @end_time = end_time
    @funeral_hall_name = funeral.funeral_hall.name
    @client_name = funeral.client.name
    @family_name = funeral.family_name
    @number_of_people = funeral.number_of_people
    @content = content
    @url = Settings.modification_report.url % user.id
    mail(from: Settings.modification_report.mail_from,
         to: Settings.modification_report.mail_to,
         subject: 'お仕事内容の修正依頼が届いています')
  end
end
