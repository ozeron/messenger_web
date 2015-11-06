class MassMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.mass_mailer.send_to_node.subject
  #
  def send_to_node(node, message, current_user)
    @text = message.content
    @title = message.title
    mail to: node.email, subject: @title, from: 'ozeron.95@mail.ru'
  end
end
