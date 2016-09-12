class AccountsBoard < BasicBoard
  attr_writer :account

  def accounts
    @accounts = Account.all
  end

  def account
    @account ||= params[:id] ? Account.find(params[:id]) : Account.new
  end
end
