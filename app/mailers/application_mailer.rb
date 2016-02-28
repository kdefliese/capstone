class ApplicationMailer < ActionMailer::Base
  default from: "kdefliese@gmail.com"
  layout 'mailer'

  def test_email(user)
    @user = user
    @url  = 'http://localhost:3000/login'
    mail(to: @user.email, subject: 'Test Email')
  end
end
