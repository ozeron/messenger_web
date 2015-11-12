class GroupsBoard < BasicBoard
  def groups
    @groups = Tag.groups
  end

  def group
    @groups = params[:id] ? Tag.find(params[:id]) : Tag.new
  end

  def group_nodes
    group.nodes
  end

  def group_node_ids
    group_nodes.map(&:id)
  end
end
