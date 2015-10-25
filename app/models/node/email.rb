class Node::Email < Node
  def self.build(attributes)
    attributes['options'] = attributes.extract!('email') || {}
    new(attributes)
  end

  def email=(value)
    options['email'] = value
  end

  def email
    options['email']
  end
end
