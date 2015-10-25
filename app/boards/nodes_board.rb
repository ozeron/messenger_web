class NodesBoard < BasicBoard
  attr_accessor :node

  def node
    @node ||= params[:id] ? Node.find(params[:id]) : Node.new
  end

  def new_vk_node
    @vk_node ||= Node::Vk.new
  end

  def new_email_node
    @email_node ||= Node::Email.new
  end

  def node_tags
    node.tag_list
  end

  def groups
    @groups ||= Group.all
  end

  def nodes
    @nodes ||= Node.all
  end
end
