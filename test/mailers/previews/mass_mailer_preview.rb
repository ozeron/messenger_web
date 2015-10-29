# Preview all emails at http://localhost:3000/rails/mailers/mass_mailer
class MassMailerPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/mass_mailer/send_to_node
  def send_to_node
    MassMailer.send_to_node
  end

end
