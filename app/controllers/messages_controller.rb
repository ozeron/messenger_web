class MessagesController < ApplicationController
  before_filter :board
  def index
  end

  def show
  end

  def new
  end

  def edit
  end

  def create
  end

  def update
  end

  def destroy
  end

  def node_params
    params.require('message')
          .permit(:title, :content, :tag_list)
  end

  def board
    @board ||= MessagesBoard.new(self)
  end
end
