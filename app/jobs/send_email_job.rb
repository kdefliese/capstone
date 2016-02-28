class SendEmailJob < ActiveJob::Base
  queue_as :default

  def perform(*args)
    # UserMailer.reminder_email(@current_user).deliver_now
  end
end
