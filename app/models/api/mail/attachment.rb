class Api::Mail::Attachment < ActiveRecord::Base

  has_attached_file :content

end
