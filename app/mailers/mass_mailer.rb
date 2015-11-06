class MassMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.mass_mailer.send_to_node.subject
  #
  def send_to_node(mass_mailing_node, _user)
    mass_mailing_node.status = 'in_progress'
    mass_mailing_node.save

    message_to_send = mass_mailing_node.message
    node = mass_mailing_node.node

    @text = message_to_send.content
    @title = message_to_send.title
    mail to: node.email, subject: @title, from: 'ozeron.95@mail.ru'
  end
end
