task :send_sample_mail => :environment do

  class TestMail < ActionMailer::Base

    def test_mail_plain_text
      mail(to: ENV["address"], subject: "automated test email", from: "ray@thelondonvandal.com") do |format|
        format.text { render :text => "Automated Test Email Without Attachments" }
      end
    end
  end

  TestMail.test_mail_plain_text.deliver

end
