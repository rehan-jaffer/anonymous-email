class Remailer < ActionMailer::Base
  default from: "remailer@personal.bosonstudios.com"

  def remail(mail_object, attachments_list=[])
      @content = mail_object["html"]

      if attachments_list.size > 0
    
        attachments_list.each do |attachment|
          Rails.logger.info attachment
          attachments[attachment["filename"]] = {mime_type: attachment["type"], content: attachment["content"]}
        end

      end

      mail(to: mail_object["address"], from: mail_object["sender"], subject: mail_object["subject"]) do |format|
              format.text { render text: mail_object["text"], layout: nil }
              format.html { render html: @content }


    end
    
   end

end
