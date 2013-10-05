class Mailbox

  def self.add(data)
    
      alphabet = [('a'..'z'), ('A'..'Z')].map { |i| i.to_a }.flatten
      mail_guid = (0...10).map{ alphabet[rand(alphabet.length)] }.join

      data.to_a.each do |datum|

        output_var = ""
        Rails.logger.info datum.to_json
        uid = datum["msg"]["to"][0][0].split("@")[0]
        REDIS.rpush("mailbox_#{uid}", mail_guid)
        REDIS.rpush("mail_queue", mail_guid)

        message_object = {}
        message_object[:sender] = datum["msg"]["from_email"]
        message_object[:text] = datum["msg"]["text"]
        message_object[:html] = datum["msg"]["html"]
        message_object[:subject] = datum["msg"]["subject"]

        REDIS.hset("mail_#{mail_guid}", "sender", message_object[:sender])    
        REDIS.hset("mail_#{mail_guid}", "text", custom_wrapper(message_object[:text]))    
        REDIS.hset("mail_#{mail_guid}", "html", message_object[:html])    
        REDIS.hset("mail_#{mail_guid}", "subject", message_object[:subject])    
        REDIS.hset("mail_#{mail_guid}", "sent", 0)

     end

  end

  def custom_wrapper(text)

    # placeholder for now
    text

  end

  def self.delete

  end

end
