class MessagesBoard < BasicBoard
  attr_accessor :message

  def message
    @node ||= params[:id] ? Message.find(params[:id]) : Message.new
  end
end
