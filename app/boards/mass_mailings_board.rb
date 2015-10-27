class MassMailingsBoard < BasicBoard
  def mass_mailings
    @mass_mailings ||= MassMailing.all
  end

  def mass_mailing
    @object ||= params[:id] ? MassMailing.find(param[:id]) : MassMailing.new
    @object.mass_mailings_nodes = 3.times.map { MassMailingsNode.new }
    @object
  end
end
