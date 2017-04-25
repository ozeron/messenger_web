class Account::UpdateService
  attr_reader :params, :object, :board, :result
  delegate :current_user, to: :board

  def initialize(params, board)
    @params = params
    @board = board
    @result = false
  end

  def perform!
    board.account.update(account_params)
    if board.account.save
      success_callback
    else
      error_callback
    end
  end

  def success?
    result == true
  end

  private

  def success_callback
    @result = true
  end

  def error_callback
  end


  def account_params
    params.require(:account)
          .permit(:vk_access_token, :vk_login, :vk_password, :vk_app_id, :port, :domain, :address, :enable_starttls_auto, :ssl, :tls, :authentication, :email_name, :email_password)
  end
end
