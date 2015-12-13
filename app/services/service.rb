class Service
  attr_reader :params, :object, :board, :result
  delegate :current_user, to: :board

  def initialize(params, board)
    @params = params
    @board = board
    @result = false
  end

  def success?
    result == true
  end
end
