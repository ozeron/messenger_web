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
    if operation.success?
      redirect_to b.mass_mailing, notice: 'Mass Mailing was successfully created.'
    else
      flash.now[:error] = b.mass_mailing.human_errors if b.mass_mailing.human_errors.present?
      render :new
    end
  end

  def retry
    attributes = board.mass_mailing.attributes
    attributes["mass_mailing_nodes_attributes"] = board.mass_mailing.mass_mailing_nodes.map { |mmn| { "node_id" => mmn.node_id, 'type' => mmn.type } }
    params[:mass_mailing] = attributes
    render :new
  end

  def destroy
    if b.mass_mailing.destroy
      redirect_to mass_mailings_path
    else
      redirect_to mass_mailing_path(b.mass_mailing)
    end
  end

  private

  def mass_mailing_params
    params.require(:mass_mailing).permit(:title, :started, :message_id, mass_mailing_nodes_attributes: [:node_id, :_destroy])
  end
end
