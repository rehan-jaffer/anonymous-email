class Mailbox

  def self.add(data)
    
      alphabet = [('a'..'z'), ('A'..'Z')].map { |i| i.to_a }.flatten
      mail_guid = (0...10).map{ alphabet[rand(alphabet.length)] }.join

      Rails.logger.info data.to_yaml

      data.to_a.each do |datum|

        Rails.logger.info datum.to_yaml
        uid = datum["msg"]["to"][0][0].split("@")[0]
        REDIS.rpush("mailbox_#{uid}", mail_guid)
        REDIS.rpush("mail_queue", mail_guid)

        message_object = {}
        message_object[:sender] = datum["from_email"]
        message_object[:text] = datum["text"]
        message_object[:html] = datum["html"]
        message_object[:subject] = datum["subject"]

        Rails.logger.info message_object.to_yaml

        REDIS.set("mail_#{mail_guid}", datum["msg"].to_json)    

     end

  end

  def self.delete

  end

end
