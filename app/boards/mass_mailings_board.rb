class MassMailingsBoard < BasicBoard
  attr_accessor :mass_mailing

  def mass_mailings
    @mass_mailings ||= MassMailing.all.order(id: :desc)
  end

  def mass_mailing
    @mass_mailing ||= params[:id] ? MassMailing.includes(mass_mailing_nodes: :node).find(params[:id]) : MassMailing.new
  end

  def mass_mailing_nodes_ids
    mass_mailing.nodes.map(&:id)
  end
end
