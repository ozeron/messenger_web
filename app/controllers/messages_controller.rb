class MessagesController < ApplicationController
  before_filter :board
  def index
    respond_to do |format|
      format.html
      format.json { render json: DataTable::Messages.new(view_context) }
    end
  end

  def show
  end

  def new
  end

  def edit
  end

  def create
    b.message = Message.new(message_params)
    respond_to do |format|
      if b.message.save
        format.html { redirect_to b.message, notice: 'Message was successfully created.' }
        format.json { render :show, status: :created, location: b.message }
      else
        format.html { render :new }
        format.json { render json: b.message.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if b.message.update(message_params)
        format.html { redirect_to b.message, notice: 'Message was successfully updated.' }
        format.json { render :show, status: :ok, location: b.message }
      else
        format.html { render :edit }
        format.json { render json: b.message.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    b.message.destroy
    respond_to do |format|
      format.html { redirect_to messages_url, notice: 'Message was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def message_params
    params.require('message')
          .permit(:title, :content, :tag_list)
  end

  def board
    @board ||= MessagesBoard.new(self)
  end
end
