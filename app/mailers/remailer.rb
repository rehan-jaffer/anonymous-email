class Remailer < ActionMailer::Base
  default from: "remailer@personal.bosonstudios.com"

  def remail(mail_object)
    mail(to: mail_object["address"], subject: mail_object["subject"]) do |format|
              format.text { render text: mail_object["text"], layout: nil }
    end

  end

end
