task :send_mail => :production do

  MailQueue.dispatch

end
