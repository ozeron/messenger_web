class NodesController < ApplicationController
  before_filter :board
  # GET /nodes
  # GET /nodes.json
  def index
    respond_to do |format|
      format.html
      format.json { render json: DataTable::Nodes.new(view_context) }
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
    b.node = type.build(node_params)

    respond_to do |format|
      if b.node.save
        format.html { redirect_to b.node, notice: 'Node was successfully created.' }
        format.json { render :show, status: :created, location: b.node }
      else
        format.html { render :new }
        format.json { render json: b.node.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /nodes/1
  # PATCH/PUT /nodes/1.json
  def update
    respond_to do |format|
      if b.node.update(node_params)
        format.html { redirect_to b.node, notice: 'Node was successfully updated.' }
        format.json { render :show, status: :ok, location: b.node }
      else
        format.html { render :edit }
        format.json { render json: b.node.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /nodes/1
  # DELETE /nodes/1.json
  def destroy
    b.node.destroy
    respond_to do |format|
      format.html { redirect_to nodes_url, notice: 'Node was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def type
    type_name.safe_constantize
  end

  def type_name
    Node.types.include?(params[:type]) ? params[:type] : 'Node'
  end

  def board
    @board = NodesBoard.new(self)
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def node_params
    params.require(type_name.parameterize('_').to_sym)
          .permit(:name, :description, :email, :vk_id, :tag_list)
  end
end
