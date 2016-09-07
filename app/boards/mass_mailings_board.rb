class MassMailingsBoard < BasicBoard
  attr_accessor :mass_mailing

  def mass_mailings
    @mass_mailings ||= MassMailing.includes(:nodes, :messages, mass_mailing_nodes: :node)
                       .all.order(id: :desc)
  end

  def mass_mailing
    return @mass_mailing if @mass_mailing.present?
    @mass_mailing = params[:id] ? MassMailing.includes(:nodes, mass_mailing_nodes: :node).find(params[:id]) : MassMailing.new
    @mass_mailing.calculate_status
    @mass_mailing
  end

  def mass_mailing_nodes_ids
    mass_mailing.nodes.map(&:id)
  end

  def mass_mailing_nodes_types
    mass_mailing.mass_mailing_nodes.select(&:post?).map(&:node_id)
  end

  def nodes
    @nodes = Node.with_tags
  end
end
