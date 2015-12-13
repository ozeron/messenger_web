class GroupsBoard < BasicBoard
  attr_accessor :group

  def groups
    @groups = Group.groups
  end

  def group
    @group ||= params[:id] ? Group.includes(:nodes).find(params[:id]) : Group.new
  end

  def group_nodes
    group.nodes.with_tags.to_a.uniq
  end

  def nodes
    @nodes ||= Node.with_tags
  end

  def all_free_nodes
    Node.all.includes_tags.where.not(id: group_node_ids)
  end

  def group_node_ids
    group_nodes.map(&:id)
  end
end
