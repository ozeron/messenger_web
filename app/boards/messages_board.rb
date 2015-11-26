class MessagesBoard < BasicBoard
  attr_accessor :message

  def message
    @message ||= params[:id] ? Message.find(params[:id]) : Message.new
  end

  def message_tags
    message.tags.map(&:name)
  end

  def messages
    @messages = Message.all.includes_tags
  end
end
