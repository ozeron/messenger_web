class MassMailingNodeSendJob < ActiveJob::Base
  queue_as :default

  def perform(mass_mailing_node_id, user_id)
    mass_mailing_node = MassMailingNode.include_nested.find(mass_mailing_node_id)
    mass_mailing_node.status = 'in_progress'
    mass_mailing_node.save
    mass_mailing = mass_mailing_node.mass_mailing
    user = mass_mailing.sender || User.find(user_id)
    mass_mailing_node.node.mailer.send_to_node(mass_mailing_node,
                                               user).deliver_now
    mass_mailing_node.status = 'success'
    mass_mailing_node.status_text = 'success'
    mass_mailing_node.save
  rescue => e
    mass_mailing_node.status = 'failed'
    mass_mailing_node.status_text = formatted_description(e) || e.message
    mass_mailing_node.save
  ensure
    mass_mailing = MassMailingNode.include_nested.find(mass_mailing_node_id).mass_mailing
    mass_mailing.processed_node_counter += 1
    mass_mailing.calculate_status
    mass_mailing.save
  end

  def formatted_description(e)
    str = e.try(:description)
    return false if str.blank?
    str.underscore.gsub(' ', '_').split(':')[0]
  end
end
