class MassMailingsController < ApplicationController
  before_filter :board

  def board
    @board ||= MassMailingsBoard.new(self)
  end

  def index
    respond_to do |format|
      format.html
    end
  end

  # GET /nodes/1
  # GET /nodes/1.json
  def show
  end

  # GET /nodes/new
  def new
  end

  # GET /nodes/1/edit
  def edit
  end

  # POST /nodes
  # POST /nodes.json
  def create
    operation = MassMailing::CreateService.new(params, board)
    operation.perform!

    respond_to do |format|
      if operation.success?
        format.html { redirect_to b.mass_mailing, notice: 'Mass Mailing was successfully created.' }
        format.json { render :show, status: :created, location: b.mass_mailing }
      else
        format.html { render :new }
        format.json { render json: b.mass_mailing.errors, status: :unprocessable_entity }
      end
    end
  end


end
