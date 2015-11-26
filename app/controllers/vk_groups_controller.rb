class VkGroupsController < ApplicationController
  load_and_authorize_resource
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
