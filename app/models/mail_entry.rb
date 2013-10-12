class MailEntry

  def initialize(mail_id)
    
    @id = mail_id
    @mail = REDIS.hgetall("mail_#{mail_id}")

  end

  def subject
    @mail.subject
  end

  def message(format="text")
    msg = case format
             when "text"
               @mail.text
             when "html"
               @mail.html
           end
    return msg
  end

  def attachments

    attachments = []
    attachment_count = REDIS.llen("mail_attachments_#{@id}")

    attachment_count.times do |n|
      n += 1
      attachments << REDIS.hgetall("mail_attachment_#{@id}_#{n}")
    end

    return attachment

  end

end
