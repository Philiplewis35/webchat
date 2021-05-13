class HardWorker
  include Sidekiq::Worker

  def perform(data)
    data.each do |user_email, mailer_data|
      UserMailer.notify_messages(user_email, mailer_data[:messages_in_last_week], mailer_data[:since_last])
    end
  end
end
