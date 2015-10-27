class MassMailingsController < InheritedResources::Base
  before_filter :board

  def board
    @board ||= MassMailingsBoard.new(self)
  end

  private

  def mass_mailing_params
    params.require(:mass_mailing).permit(:title, :started, :finished)
  end
end
