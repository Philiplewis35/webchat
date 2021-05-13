module ApplicationHelper
  LAST_RECEIVED_PERIOD = 7

  def flash_class(level)
    case level
    when :notice then "alert alert-primary"
        when :success then "alert alert-success"
        when :error then "alert alert-danger"
        when :alert then "alert alert-primary"
    end
  end

  def send_emails
    results = {}
    weekly = <<~HEREDOC
      SELECT users.email, COUNT(messages) as weekly FROM users
      INNER JOIN user_channels ON user_channels.user_id = users.id
      INNER JOIN channels ON user_channels.channel_id = channels.id
      INNER JOIN messages ON messages.channel_id = channels.id
      WHERE messages.created_at > (current_date - integer '#{LAST_RECEIVED_PERIOD}')
      GROUP BY users.id
    HEREDOC
    ActiveRecord::Base.connection.execute(weekly).map { |result| results[result["email"].to_sym] = { messages_in_last_week: result["weekly"] } }

    since_last_message = <<~HEREDOC
      SELECT users.email, COUNT(messages) as since_last FROM users
      INNER JOIN user_channels ON user_channels.user_id = users.id
      INNER JOIN channels ON user_channels.channel_id = channels.id
      INNER JOIN messages ON messages.channel_id = channels.id
      WHERE messages.created_at > (SELECT messages.created_at FROM users
                                   INNER JOIN user_channels ON user_channels.user_id = users.id
                                   INNER JOIN channels ON user_channels.channel_id = channels.id
                                   INNER JOIN messages ON messages.channel_id = channels.id
                                   ORDER BY messages.created_at ASC
                                   LIMIT 1)
      GROUP BY users.id
    HEREDOC
    ActiveRecord::Base.connection.execute(since_last_message).map { |result| results[result["email"].to_sym][:since_last] = result["since_last"]}
    results
  end
end
