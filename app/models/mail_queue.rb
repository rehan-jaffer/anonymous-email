class MailQueue

  def self.list
    entries = REDIS.llen
  end

  def self.dispatch
    entries = REDIS.llen("mail_queue")
    queue = REDIS.lrange("mail_queue", 0, entries)
    
    queue.each do |item|
      
      mail = REDIS.hgetall("mail_#{item}")
      mailer = Remailer.remail(mail).deliver
      Rails.logger.info mail.to_yaml

    end

  end

end
