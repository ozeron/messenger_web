class MassMailingsBoard < BasicBoard
  attr_accessor :mass_mailing

  def mass_mailings
    @mass_mailings ||= MassMailing.all
  end

  def mass_mailing
    @mass_mailing ||= params[:id] ? MassMailing.find(param[:id]) : MassMailing.new
  end

  def mass_mailing_nodes_ids
    mass_mailing.nodes.map(&:id)
  end
end
