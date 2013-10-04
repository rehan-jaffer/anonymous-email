class Mailbox

  def self.add(data)
    
      alphabet = [('a'..'z'), ('A'..'Z')].map { |i| i.to_a }.flatten
      mail_guid = (0...10).map{ alphabet[rand(alphabet.length)] }.join

      data.to_a.each do |datum|

        uid = datum["msg"]["to"].split("@")[0]
        REDIS.rpush("mailbox_#{uid}", mail_guid)
        REDIS.rpush("mail_queue", mail_guid)
        REDIS.set("mail_#{mail_guid}", datum["msg"].to_json)      

     end

  end

  def self.delete

  end

end
