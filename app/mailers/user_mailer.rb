class UserMailer < Devise::Mailer
  def confirmation_instructions(record, opts={})
    set_locale(record)
      headers['X-MC-Track'] = "False, False"
    super
  end
end
