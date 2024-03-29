class Node::Vk < Node
  def self.build(attributes)
    attributes['options'] = attributes.extract!('vk_id') || {}
    new(attributes)
  end

  def description_human
    description
  end

  def vk_id=(value)
    options['vk_id'] = value
  end

  def vk_id
    options['vk_id']
  end

  def mailer
    VkMailer
  end
end
