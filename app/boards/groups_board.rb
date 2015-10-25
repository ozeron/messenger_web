class GroupsBoard < BasicBoard
  attr_accessor :group

  def group
    @group ||= params[:id] ? Group.find(params[:id]) : Group.new
  end

  def parent?
    parent != group
  end

  def parent
    @parent ||= group.parent
  end

  def group_nodes
    @group.nodes
  end

  def group_children
    group.children
  end

  def groups
    @groups ||= Group.all.order(:id)
  end

  def nodes
    @nodes ||= Node.all.order(:name)
  end

end
