class VkGroupsController < ApplicationController
  before_filter :board

  def index
    respond_to do |format|
      format.json { render :index }
    end
  end

  def board
    @board = VkGroupsBoard.new(self)
  end
end
