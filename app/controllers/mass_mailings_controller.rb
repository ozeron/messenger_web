class MassMailingsController < ApplicationController
  load_and_authorize_resource
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
  # def edit
  # end

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

  def retry
    attributes = board.mass_mailing.attributes
    attributes["mass_mailing_nodes_attributes"] = board.mass_mailing.mass_mailing_nodes.map { |mmn| { "node_id" => mmn.node_id } }
    params[:mass_mailing] = attributes
    create
  end

  def try_more
    board.mass_mailing.title += ' (unsent)'
    attributes = board.mass_mailing.attributes
    filtered = board.mass_mailing.mass_mailing_nodes.select{ |mmn| mmn.status_text != 'success'}
    attributes["mass_mailing_nodes_attributes"] = filtered.map { |mmn|  {"node_id" => mmn.node_id  }  }
    params[:mass_mailing] = attributes
    create
  end

  helper_method :isUnsent

  def isUnsent(mass_mailing)
    mass_mailing.mass_mailing_nodes.each do |mmn|
      return true if mmn.status_text !=  'success'
    end
    return false
  end

  private

  def mass_mailing_params
    params.require(:mass_mailing).permit(:title, :started, :message_id, mass_mailing_nodes_attributes: [:node_ir, :_destroy])
  end
end
