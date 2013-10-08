class Remailer < ActionMailer::Base
  default from: "remailer@personal.bosonstudios.com"

  def remail(mail_object)
    @content = mail_object["html"]
    mail(to: mail_object["address"], subject: mail_object["subject"]) do |format|
              format.text { render text: mail_object["text"], layout: nil }
              format.html { render html: @content }
    end

  end

end
