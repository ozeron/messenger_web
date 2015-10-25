class BasicBoard
  def initialize(scope)
    @scope = scope
  end

  def scope
    @scope
  end

  def node_name
    node.name
  end

  def groups
    @node.groups
  end

  def groups_present
    groups.present?
  end

  protected :scope

  def method_missing(name, *args, &block)
    return super if args.any?

    if scope.respond_to?(name)
      scope.send(name)
    else
      super
    end
  end
end
