class Mailbox

  def self.add(data)
    
      alphabet = [('a'..'z'), ('A'..'Z')].map { |i| i.to_a }.flatten
      mail_guid = (0...10).map{ alphabet[rand(alphabet.length)] }.join

      data.to_a.each do |datum|

        output_var = ""
        Rails.logger.info datum.to_json
        uid = datum["msg"]["to"][0][0].split("@")[0]
        real_address = User.find_by_uid(uid).email
        REDIS.rpush("mailbox_#{uid}", mail_guid)
        REDIS.rpush("mail_queue", mail_guid)

        message_object = {}
        message_object[:sender] = datum["msg"]["from_email"]
        message_object[:sender] = datum["msg"]["from_name"]
        message_object[:text] = datum["msg"]["text"]
        message_object[:html] = datum["msg"]["html"]
        message_object[:subject] = datum["msg"]["subject"]

        REDIS.hset("mail_#{mail_guid}", "sender", message_object[:sender])    
        REDIS.hset("mail_#{mail_guid}", "name", message_object[:name])    
        REDIS.hset("mail_#{mail_guid}", "address", real_address)
        REDIS.hset("mail_#{mail_guid}", "uid", uid)
        REDIS.hset("mail_#{mail_guid}", "text", message_object[:text])    
        REDIS.hset("mail_#{mail_guid}", "html", message_object[:html])    
        REDIS.hset("mail_#{mail_guid}", "subject", message_object[:subject])    

        if !datum["msg"]["attachments"].nil? && datum["attachments"].to_a.size > 0

          n = 0

          datum["msg"]["attachments"].each do |attachment|
            Rails.logger.info attachment.to_yaml
            n += 1
            REDIS.rpush("mail_attachments_#{mail_guid}", "#{mail_guid}_#{n}")
            REDIS.hset("mail_attachment_#{mail_guid}_#{n}", "filename", attachment["name"])
            REDIS.hset("mail_attachment_#{mail_guid}_#{n}", "type", attachment["type"])
            REDIS.hset("mail_attachment_#{mail_guid}_#{n}", "content", attachment["content"])
            REDIS.hset("mail_attachment_#{mail_guid}_#{n}", "base64", attachment["base64"])
          end

          REDIS.hset("mail_#{mail_guid}", "has_attachments", 1)

        else
          REDIS.hset("mail_#{mail_guid}", "has_attachments", 0)
        end

        REDIS.hset("mail_#{mail_guid}", "sent", 0)

        Rails.logger.info datum.to_yaml

     end

  end

  def custom_wrapper(text)

    # placeholder for now
    text

  end

  def self.delete

  end

end
