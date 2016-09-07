class AccountsController < ApplicationController
  load_and_authorize_resource
  before_filter :board

  def board
    @board ||= AccountsBoard.new(self)
  end

  def index
  end

  def show
  end

  def new
  end

  def edit
  end

  def destroy
  end
end
