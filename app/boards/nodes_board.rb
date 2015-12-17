class NodesBoard < BasicBoard
  attr_accessor :node

  def node
    @node ||= params[:id] ? Node.find(params[:id]) : Node.new
  end

  def vk_node
    node.becomes(Node::Vk)
  end

  def email_node
    node.becomes(Node::Email)
  end

  def node_tags
    node.tag_list
  end

  def nodes
    @nodes ||= Node.all.includes(:tags)
  end
end
