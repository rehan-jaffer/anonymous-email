class Remailer < ActionMailer::Base
  default from: "remailer@personal.bosonstudios.com"

  def remail(mail_object, attachments)
    @content = mail_object["html"]

      if attachments.size > 0
    
        mail_attachments = {}

        attachments.each do |attachment|
          mail_attachments[attachment["name"]] = {mime_type: attachment["type"], content: attachment["content"]}
        end

      end

      Rails.logger.info attachments.to_yaml

      mail(to: mail_object["address"], subject: mail_object["subject"], attachments: mail_attachments) do |format|
              format.text { render text: mail_object["text"], layout: nil }
              format.html { render html: @content }


    end
    
   end

end
