class MassMailing::CreateService
  attr_reader :params, :object, :board, :result
  delegate :current_user, to: :board

  def initialize(params, board)
    @params = params
    @board = board
    @result = false
  end

  def perform!
    @object = MassMailing.new(mass_mailing_params)
    if object.save
      success_callback
    else
      error_callback
    end
    board.mass_mailing = @object
  end

  def success?
    result == true
  end

  private

  def success_callback
    @result = true
    object.reload
    object.mass_mailing_nodes.each do |mmn|
      MassMailingNodeSendJob.new(mmn.id, current_user.id).perform_now
    end
  end

  def error_callback
  end

  def mass_mailing_params
    params.require(:mass_mailing).permit(:title, :started, :finished, :message_id,
                                          { mass_mailing_nodes_attributes: [:id, :node_id, :_destroy]})
  end
end