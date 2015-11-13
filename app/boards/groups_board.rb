class GroupsBoard < BasicBoard
  attr_accessor :group

  def groups
    @groups = Tag.groups
  end

  def group
    @group ||= params[:id] ? Tag.find(params[:id]) : Tag.new
  end

  def group_nodes
    group.nodes
  end

  def group_node_ids
    group_nodes.map(&:id)
  end
end
