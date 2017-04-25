class VkMailer
  attr_reader :vk_client, :node, :message_to_send, :mass_mailing

  def self.send_to_node(*args)
    new.send_to_node(*args)
  end

  def send_to_node(mass_mailing_node, user)
    @message = mass_mailing_node.message
    @node = mass_mailing_node.node
    @mass_mailing = mass_mailing_node.mass_mailing
    @vk_client = @mass_mailing.sender.vk_app
    mass_mailing_node.status = 'in_progress'
    mass_mailing_node.save


    return MailerResponce.new unless @node.is_a? Node::Vk
    attachments = attachment_string(@message)
    hash = {
      owner_id: node_id,
      message: @message.content,
      attachments: attachments
    }
    
    if mass_mailing_node.post?
      vk_client.wall.post(hash)
    else
      filtered_posts_id.each do |post_id|
        vk_client.wall.addComment(hash.merge({post_id: post_id}))
        sleep(rand(20))
      end
    end
    MailerResponce.new
  end

  def attachment_string(message)
    result = []
    if message.pic1_exist?
      result << @vk_client.attach_document(message.pic1.path,
                                           message.pic1.content_type)
    end

    if message.doc1_exist?
      result << @vk_client.attach_document(message.pic1.path,
                                           message.pic1.content_type)
    end
    result.join(',')
  end

  def node_id
    i = node.vk_id.to_i
    i < 0 ? i : -1 * i
  end

  def filtered_posts_id
    posts_id.select.with_index(&comment_strategy_proc)
  end

  def comment_strategy_proc
    mass_mailing.comment_strategy_proc[mass_mailing.comment_strategy]
  end

  def posts_id
    @posts_id ||= vk_client.wall
                      .get(owner_id: node_id, offset: mass_mailing.span, count: mass_mailing.comment_count )['items']
                      .map { |h| h['id'] }
  end
end
