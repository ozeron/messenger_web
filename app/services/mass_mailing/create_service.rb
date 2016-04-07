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
      perform_job(mmn.id, current_user.id)
    end
  end

  def perform_job(id, user_id)
    # if Time.now < object.started
    #   MassMailingNodeSendJob.set(wait_until: object.started).perform_later(id, user_id)
    # else
    if Rails.env.development?
      MassMailingNodeSendJob.perform_now(id, user_id)
    else
      MassMailingNodeSendJob.perform_later(id, user_id)
    end
  end

  def error_callback
  end

  def mass_mailing_params
    params.require(:mass_mailing).permit(:title, :started, :finished, :message_id, :sender_id,
                                          { mass_mailing_nodes_attributes: [:id, :node_id, :_destroy]})
  end
end
