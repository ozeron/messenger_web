class GroupsController < ApplicationController
  before_filter :board

  def index
  end

  def show
  end

  def new
  end

  def board
    @board = GroupsBoard.new(self)
  end
end
