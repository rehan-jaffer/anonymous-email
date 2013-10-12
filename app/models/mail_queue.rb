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

    attachments_list = REDIS.lrange("mail_attachments_#{item}", 0, attachments.to_i)

    mail_attachments = []

    n = 0

    if attachments.to_i > 0
      attachments_list.each do |item_name|
        mail_attachments << REDIS.hgetall("mail_attachment_#{item_name}")
      end

    end

#    begin

      mail = REDIS.hgetall("mail_#{item}")
      mailer = Remailer.remail(mail, mail_attachments).deliver
      REDIS.lpop("mail_queue")
      REDIS.hset("mail_#{item}", "sent", 1)
      report[:sends] += 1

      success = Report.new(mail["sender"], mail["address"], "success", "mail_#{item}")
      success.save      

#    rescue Exception => e

#      Rails.logger.info e.inspect.to_yaml
#      report[:failures] += 1

#      error = Report.new(mail["sender"], mail["address"], "error", item)
#      error.save

#    end
#      Rails.logger.info report.to_yaml

#    end

  end

end
