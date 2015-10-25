class NodesBoard < BasicBoard
  attr_accessor :node

  def node
    @node ||= params[:id] ? Node.find(params[:id]) : Node.new
  end

  def node_groups
    node.groups
  end

  def groups
    @groups ||= Group.all
  end

  def nodes
    @nodes ||= Node.all
  end
end
