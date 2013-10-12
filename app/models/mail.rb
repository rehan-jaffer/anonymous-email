class Mail

  def initializer(mail_id)
    
    @id = mail_id
    @mail = REDIS.hgetall("mail_#{mail_id}")

  end

  def subject
    @mail.subject
  end

  def message(format="text")
    return case format
             when "text"
               @mail.text
             when "html"
               @mail.html
           end
  end

  def attachments

    attachments = []
    attachment_count = REDIS.llen("mail_attachments_#{id}")
    attachments << REDIS.hgetall("mail_attachment_#{id}")
    return attachment

  end

end
