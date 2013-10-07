class MailQueue

  def self.list
    entries = REDIS.llen
  end

  def self.dispatch
    entries = REDIS.llen("mail_queue")
    queue = REDIS.lrange("mail_queue", 0, entries)

    report = {sends: 0, failures: 0}
    
    queue.each do |item|
      
      mail = REDIS.hgetall("mail_#{item}")
      mailer = Remailer.remail(mail).deliver
      REDIS.lpop("mail_queue")
      REDIS.hset("mail_#{item}", "sent", 1)
      report[:sends] += 1
#        report[:failures] += 1
#        REDIS.lpush("errors", item)

      Rails.logger.info report.to_yaml

    end

  end

end
