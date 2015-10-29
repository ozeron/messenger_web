class MassMailingsBoard < BasicBoard
  attr_accessor :mass_mailing

  def mass_mailings
    @mass_mailings ||= MassMailing.all
  end

  def mass_mailing
    @mass_mailing ||= params[:id] ? MassMailing.find(param[:id]) : MassMailing.new
  end
end
