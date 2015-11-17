class GroupsBoard < BasicBoard
  attr_accessor :group

  def groups
    @groups = Tag.groups
  end

  def group
    @group ||= params[:id] ? Tag.includes(:nodes).find(params[:id]) : Tag.new
  end

  def group_nodes
    group.nodes
  end

  def all_free_nodes
    Node.all.includes_tags.where.not(id: group_node_ids)
  end

  def group_node_ids
    group_nodes.map(&:id)
  end
end
