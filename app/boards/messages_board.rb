class MessagesBoard < BasicBoard
  attr_accessor :message

  def message
    @message ||= params[:id] ? Message.find(params[:id]) : Message.new
  end
end
