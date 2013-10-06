task :send_mail => :environment do

  MailQueue.dispatch

end
