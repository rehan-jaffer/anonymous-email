task :send_mail => :environment do

  Api::Mail::MailQueue.dispatch

end

