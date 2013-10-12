class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable, :token_authenticatable

  validates_uniqueness_of :email

  after_create :add_uid

  def add_uid
   self.uid = generate_uid(8)
   save
  end

  def generate_uid(length)

  alphabet = [('a'..'z')].map { |i| i.to_a }.flatten
  string = (0...length).map{ alphabet[rand(alphabet.length)] }.join
    
  end

  def get_mail(guid)

   return REDIS.hget("mail_#{params[:guid]}")

  end

  def mailbox(page)

   mail_paginator = RedisPagination.paginate("mailbox_#{uid}")
   keys = mail_paginator.page(page)[:items]

   mail = []

   keys.each do |key|

     begin
       mail << Mail.new(key)
     end


   end
  
   return mail
  
  end

  def as_json(opts={})
    {:email => email, :received_emails => 0, :anonymous_email => "#{uid}@personal.bosonstudios.com"}
  end

end
