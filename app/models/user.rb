class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable

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

  def mailbox

   mail = []
   keys = REDIS.lrange("mailbox_#{uid}", 0, 10)
   keys.each do |key|

     begin
       mail << REDIS.hgetall("mail_#{key}")
     end

   end
  
   return mail
  
  end

end
