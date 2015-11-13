class GroupsController < ApplicationController
  before_filter :board

  def index
  end

  def show
  end

  def new
  end

  def create
    byebug
    
  end

  def edit
  end

  def board
    @board = GroupsBoard.new(self)
  end

  def groups_params
    params.require('tag')
      .permit(:name)
  end
end
