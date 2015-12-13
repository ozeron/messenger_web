class GroupsController < ApplicationController
  #load_and_authorize_resource
  before_filter :board

  def index
  end

  def show
  end

  def new
  end

  def create
    operation = Group::UpdateService.new(params, board)
    operation.perform!
    if operation.success?
      flash.now[notice] = t('.succeed')
      redirect_to group_path(b.group)
    else
      flash.now[:alert] = t('.failed')
      byebug
      flash.now[:error] = b.group.human_errors if b.group.human_errors.present?
      render :new
    end
  end

  def update
    operation = Group::UpdateService.new(params, board)
    operation.perform!
    if operation.success?
      flash.now[notice] = t('.succeed')
      redirect_to group_path(b.group)
    else
      flash.now[:alert] = t('.failed')
      flash.now[:error] = b.group.human_errors if b.group.human_errors.present?
      render :edit
    end
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
