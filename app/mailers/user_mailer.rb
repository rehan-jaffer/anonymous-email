class UserMailer < Devise::Mailer

  def confirmation_instructions(record, opts={})
      headers['X-MC-Track'] = "False, False"
    super
  end

end
