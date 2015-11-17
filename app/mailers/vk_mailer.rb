class VkMailer
  attr_reader :vk_client, :node, :message_to_send

  def self.send_to_node(*args)
    new.send_to_node(*args)
  end

  def send_to_node(mass_mailing_node, user)
    @vk_client = user.vk_app
    mass_mailing_node.status = 'in_progress'
    mass_mailing_node.save

    @message = mass_mailing_node.message
    @node = mass_mailing_node.node
    return unless Node.is_a? Node::Vk
    posts_id.each do |post_id|
      vk_client.wall.addComment(post_id: post_id,
                                owner_id: node_id,
                                text: message.content)
    end
    MailerResponce.new
  end

  def node_id
    node.vk_id
  end

  def posts_id
    @posts_id ||= vk_client.wall.get(owner_id: node_id)['items']
                  .map { |h| h['id'] }
  end
end
