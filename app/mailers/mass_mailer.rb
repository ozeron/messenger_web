class MassMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.mass_mailer.send_to_node.subject
  #
  def self.send_to_node(*args)
    new.send_to_node(*args)
  end

  def send_to_node(mass_mailing_node, user)
    mass_mailing_node.status = 'in_progress'
    mass_mailing_node.save

    message_to_send = mass_mailing_node.message
    node = mass_mailing_node.node

    @text = message_to_send.content
    @title = message_to_send.title
    smtp_settings = default.merge(user.email_parameters || {}).symbolize_keys
    hash = {
      to: node.email,
      from: user.email_name,
      subject: @title,
      body: @text,
      via: :smtp,
      via_options: smtp_settings
    }
    Pony.mail(hash)
    MailerResponce.new
  end

  def default
    Rails.application.config.action_mailer.smtp_settings
  end
end
