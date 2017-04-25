class Account::CreateService
  attr_reader :params, :object, :board, :result
  delegate :current_user, to: :board

  def initialize(params, board)
    @params = params
    @board = board
    @result = false
  end

  def perform!
    @object = Account.new(account_params)
    if object.save
      success_callback
    else
      error_callback
    end
    board.account = @object
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
          .permit(:vk_app_id, :vk_access_token, :port, :domain, :address, :enable_starttls_auto, :ssl, :tls, :authentication, :email_name, :email_password)
  end
end
