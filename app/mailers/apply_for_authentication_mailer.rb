class ApplyForAuthenticationMailer < ApplicationMailer
  def send_mail(applicant)
    @applicant_name = applicant.family_name + applicant.first_name
    @url = Settings.apply_for_authentication.url % applicant.id
    mail(from: "tsuna.tonight@gmail.com",
         to: Settings.apply_for_authentication.mail_to,
         subject: 'スタッフ登録申請が届いています')
  end
end
