class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :authenticate_user!
  around_filter :set_user_time_zone_and_language

  before_filter do
   resource = controller_name.singularize.to_sym
   method = "#{resource}_params"
   params[resource] &&= send(method) if respond_to?(method, true)
 end

  def board
    @board ||= BasicBoard.new(self)
  end
  alias_method :b, :board
  helper_method :board, :b

  def js_class_name
    action = case action_name
             when 'create' then 'New'
             when 'update' then 'Edit'
             else action_name
             end.camelize
    "Views.#{self.class.name.gsub('::', '.').gsub(/Controller$/, '')}.#{action}View"
  end
  helper_method :js_class_name

  def set_user_time_zone_and_language
    if current_user
      I18n.locale = current_user.language if current_user.language
    end
    yield
  ensure
    I18n.locale = I18n.default_locale
  end

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to main_app.root_path, alert: exception.message
  end
end
