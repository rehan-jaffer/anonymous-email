class MailQueue

  def list
    entries = REDIS.llen
  end

  def dispatch
    entries = REDIS.llen
    queue = REDIS.lrange("mail_queue", 0, entries)
  end

end
