class MassMailingNodesController < ApplicationController
  def index
    respond_to do |format|
      format.html
      format.json { render json: DataTable::MassMailingsNodes.new(view_context) }
    end
  end
end
