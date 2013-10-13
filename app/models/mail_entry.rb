class MailEntry

  attr_reader :subject, :sender, :address, :name, :html, :text

  def initialize(mail_id)
    
    @id = mail_id
    mail = REDIS.hgetall("mail_#{mail_id}")
    @subject = mail["subject"]
    @sender = mail["sender"]
    @address = mail["address"]
    @text = mail["text"]
    @html = mail["html"]    
    @name = mail["name"]
    @has_attachments = mail["has_attachments"]
    @sent = mail["sent"]
  end

  def as_json(opts={})
    {:uid => @id, :subject => @sender, :address => @address, :text => @text, :html => @html, :name => @name, :has_attachments => @has_attachments, :sent => @sent}
  end

  def attachments

    if !@attachments.nil?
      return @attachments
    end

    attachments = []
    attachment_count = REDIS.llen("mail_attachments_#{@id}")

    attachment_count.times do |n|
      n += 1
      attachments << REDIS.hgetall("mail_attachment_#{@id}_#{n}")
    end

    @attachments = attachments

    return @attachments

  end

end
