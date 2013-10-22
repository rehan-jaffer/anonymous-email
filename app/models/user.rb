class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable, :token_authenticatable

  rolify

  validates_uniqueness_of :email

  after_create :add_uid

  def add_uid
   self.uid = generate_uid(8)
   save
  end

  def make_admin!
    add_role :admin
  end

  def unmake_admin!
    remove_role :admin
  end

  def generate_uid(length)

  alphabet = [('a'..'z')].map { |i| i.to_a }.flatten
  string = (0...length).map{ alphabet[rand(alphabet.length)] }.join
    
  end

  def get_mail(guid)

   return REDIS.hgetall("mail_#{guid}")

  end

  def mailbox(page)

   mail_paginator = RedisPagination.paginate("mailbox_#{uid}")
   keys = mail_paginator.page(page)[:items]

   mail = []

   keys.each do |key|
       mail << Api::Mail::MailEntry.new(key)
   end
  
   return mail
  
  end

  def anonymous_email
    "#{uid}@#{ENV['EMAIL_DOMAIN']}"
  end

  def as_json(opts={})
    {:email => email, :received_emails => received_emails, :anonymous_email => "#{uid}@#{ENV['EMAIL_DOMAIN']}"}
  end

end
