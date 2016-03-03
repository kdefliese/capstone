desc 'send reminder email'
task send_reminder_email: :environment do
  @users = User.all
  @users.each do |user|
    UserMailer.reminder_email(user).deliver!
  end
end
