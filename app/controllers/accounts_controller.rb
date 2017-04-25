class AccountsController < ApplicationController
  load_and_authorize_resource except: :create
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

  def create
    fix_params
    operation = Account::CreateService.new(params, board)
    operation.perform!
    if operation.success?
      redirect_to b.account, notice: 'Mass Mailing was successfully created.'
    else
      flash.now[:error] = b.account.human_errors if b.account.human_errors.present?
      render :new
    end
  end

  def edit
  end

  def update
    fix_params
    operation = Account::UpdateService.new(params, board)
    operation.perform!
    if operation.success?
      redirect_to b.account, notice: 'Mass Mailing was successfully updated.'
    else
      flash.now[:error] = b.account.errors.full_messages if b.account.errors.present?
      render :edit
    end
  end

  def destroy
    if b.account.destroy
      redirect_to accounts_path
    else
      redirect_to account_path(b.account)
    end
  end

  def fix_params
    params[:account].extract!(:email_password) if params[:account][:email_password].blank?
    params[:account].extract!(:vk_password) if params[:account][:vk_password].blank?
    params[:account][:ssl] = (params[:account][:ssl] == '1') ? true : false
    params[:account][:tls] = (params[:account][:tls] == '1') ? true : false
    params[:account][:enable_starttls_auto] = params[:account][:enable_starttls_auto] == '1' ? true : false
  end

  private

  def account_params
    params.require(:account).permit(:vk_access_token, :vk_login, :vk_password, :vk_app_id, :port, :domain, :address, :enable_starttls_auto, :ssl, :tls, :authentication, :email_name, :email_password)
  end
end
