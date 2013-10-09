class Remailer < ActionMailer::Base
  default from: "remailer@personal.bosonstudios.com"

  def remail(mail_object, attachments)
    @content = mail_object["html"]
    mail(to: mail_object["address"], subject: mail_object["subject"]) do |format|
              format.text { render text: mail_object["text"], layout: nil }
              format.html { render html: @content }

      if attachments.size > 0
    
        attachments.each do |attachment|
          attachments[attachment["name"]] = {mime_type: attachment["type"], content: attachment["content"]}
        end

      end

    end
    
   end

end
