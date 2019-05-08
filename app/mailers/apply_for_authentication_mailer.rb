class ApplyForAuthenticationMailer < ApplicationMailer
  def send_mail(applicant)
    @applicant_name = applicant.name
    @url = Settings.apply_for_authentication.url % applicant.id
    mail(from: Settings.apply_for_authentication.mail_from,
         to: Settings.apply_for_authentication.mail_to,
         subject: 'スタッフ登録申請が届いています')
  end
end
