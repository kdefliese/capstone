class ApplicationMailer < ActionMailer::Base
  default from: "kdefliese@gmail.com"
  layout 'mailer'

  def reminder_email(user)
    @user = user
    @url  = 'http://localhost:3000/login'
    mail(to: @user.email, subject: 'Reminder Email')
  end
end
