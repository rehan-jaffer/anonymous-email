class Mailbox

  def self.add(data)
    
      alphabet = [('a'..'z'), ('A'..'Z')].map { |i| i.to_a }.flatten
      mail_guid = (0...10).map{ alphabet[rand(alphabet.length)] }.join

      uid = data["msg"]["to"].split("@")[0]
      REDIS.rpush("mailbox_#{uid}", mail_guid)
      REDIS.rpush("mail_queue", mail_guid)
      REDIS.set("mailbox_#{mail_guid}", data["msg"].to_json)      

  end

  def delete

  end

end
