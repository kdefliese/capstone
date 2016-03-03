desc 'send reminder email'
task send_reminder_email: :environment do
  @user = User.find(1)
  UserMailer.reminder_email(@user).deliver!
end
