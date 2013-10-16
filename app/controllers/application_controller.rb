require 'digest/hmac'
require 'digest/sha1'
require 'base64'
require 'openssl'

class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  helper_method :current_user

  def after_sign_in_path_for(resource) 
    return "/"
  end

  private

   def auth_key
     "DQ9S63FpFBFr5mCJiAXvtw"
   end

   def check_sender_integrity

       encoding_string = HOOK_URL

       params.except(:action, :controller).keys.sort.each do |key|
          encoding_string += CGI.unescape(key.to_s)
          encoding_string += params[key]
        end

       webhook_key = request.headers["X-Mandrill-Signature"]

       digest = OpenSSL::Digest.new('sha1')
       generated_signature = Base64.encode64(OpenSSL::HMAC.digest(digest, auth_key, encoding_string)).strip
       Rails.logger.info webhook_key
       Rails.logger.info generated_signature

       if webhook_key == generated_signature
         return true
       else
         raise SecurityError, :error => "#{generated_signature} does not match #{webhook_key}"
       end

   end

end
