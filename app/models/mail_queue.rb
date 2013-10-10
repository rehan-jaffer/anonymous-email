class MailQueue

  def self.list
    entries = REDIS.llen
  end

  def self.dispatch

    entries = REDIS.llen("mail_queue")
    queue = REDIS.lrange("mail_queue", 0, entries)

    report = {sends: 0, failures: 0}
    
    queue.each do |item|

    attachments = REDIS.llen("mail_attachments_#{item}")

    mail_attachments = []

    n = 0

    if attachments.to_i > 0
      attachments.times do |n|
        n += 1
        mail_attachments << REDIS.hgetall("mail_attachment_#{item}_#{n}")
      end

    end

    begin

      mail = REDIS.hgetall("mail_#{item}")
      mailer = Remailer.remail(mail, mail_attachments).deliver
      REDIS.lpop("mail_queue")
      REDIS.hset("mail_#{item}", "sent", 1)
      report[:sends] += 1

      success = Report.new(mail["from"], mail["to"], "success", "mail_#{item}")
      success.save      

    rescue Exception => e

      Rails.logger.info e.inspect.to_yaml
      report[:failures] += 1

      error = Report.new(mail["from"], mail["to"], "error", item)
      error.save

    end
      Rails.logger.info report.to_yaml

    end

  end

end
