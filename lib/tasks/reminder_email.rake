desc 'send reminder email'
task send_reminder_email: :environment do
  @users = User.all
  @users.each do |user|
    # if there are no entries for today's day for this user, send an email
    days = Day.where("user_id = ?", user.id).order(:day)
    hopefully_today = days.last
    if hopefully_today.day.today?
      if !hopefully_today.entries.empty?
        UserMailer.reminder_email(user).deliver!
      end
    end
  end
end
