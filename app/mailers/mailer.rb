class Mailer < ActionMailer::Base
  include Resque::Mailer
  default from: ENV["GMAIL_ADDRESS"]

  def send_alarm(alarm_id)
    alarm = Alarm.find(alarm_id)
    mail(to: alarm.email, subject: "#{alarm.subject_code} #{alarm.lecture_code} #{alarm.lecturer}")
  end
end
