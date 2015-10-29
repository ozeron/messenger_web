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
    b.mass_mailing = MassMailing.new(mass_mailing_params)

    respond_to do |format|
      if b.mass_mailing.save
        b.mass_mailing.nodes do |node|
          MassMailer.send_to_node(node, b.mass_mailing.message, current_user).deliver
        end
        format.html { redirect_to b.mass_mailing, notice: 'Mass Mailing was successfully created.' }
        format.json { render :show, status: :created, location: b.mass_mailing }
      else
        byebug
        format.html { render :new }
        format.json { render json: b.mass_mailing.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /nodes/1
  # PATCH/PUT /nodes/1.json
  def update
    respond_to do |format|
      if b.mass_mailing.update(mass_mailing_params)
        format.html { redirect_to b.mass_mailing, notice: 'Mass Mailing was successfully updated.' }
        format.json { render :show, status: :ok, location: b.mass_mailing }
      else
        format.html { render :edit }
        format.json { render json: b.mass_mailing.errors, status: :unprocessable_entity }
        puts b.mass_mailing.errors
      end
    end
  end

  # DELETE /nodes/1
  # DELETE /nodes/1.json
  def destroy
    b.mass_mailing.destroy
    respond_to do |format|
      format.html { redirect_to mass_mailings_url, notice: 'Mass mailing was successfully destroyed.' }
      format.json { head :no_content }
    end
  end



  private

  def mass_mailing_params
    params.require(:mass_mailing).permit(:title, :started, :finished, :message_id)
  end
end
