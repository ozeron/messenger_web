require 'byebug'

module ApiWrapper
  class VkFabric < BasicObject
    attr_reader :api, :login, :password, :app_id, :access_token

    SETTINGS = 'notify,friends,offline,messages,groups,photos,docs,wall'

    def self.build(params)
      new(params).api
    end

    def self.auth_url(params = {})
      redirect_uri = 'localhost:8000'
      ::VK::Application.new.authorization_url(
        type: :client,
        app_id: params['app_id'] || '{app_id}',
        settings: SETTINGS,
        redirect_uri: params['redirect_uri'] || redirect_uri)
    end

    def initialize(params)
      @login = params['login']
      @password = params['password']
      @app_id = params['app_id']
      @access_token = params['access_token']
      application ||= ::VK::Application.new(settings: SETTINGS) do |a|
        a.app_id = app_id if app_id.present?
        a.access_token = access_token if access_token.present?
      end
      @api = ::VK::ApplicationDecorator.new(application)
      check_connection
    end
    #
    # def method_missing(method, *args, &block)
    #   safe_request(method, *args, &block)
    # end
    #
    # def safe_request(method, *args, &block)
    #   result = nil
    #   err = nil
    #   3.times do
    #     result, err = make_request_to_api(method, *args, &block)
    #     break if err.blank?
    #   end
    #   fail err if err.present?
    #   result
    # end
    #
    # def make_request_to_api(method, *args, &block)
    #   result = api.public_send(method, *args, &block)
    #   return result, nil
    # rescue ::Faraday::ConnectionFailed => e
    #   Rails.logger.debug("Faraday: #{e}")
    #   byebug
    #   return nil, e
    # end

    private

    def check_connection
      return if api.users.get.present?
#      api.client_auth(login: login, password: password)
    rescue ::VK::APIError => e
      ::Rails.logger.debug("ApiError: #{e}")
#      api.client_auth(login: login, password: password)
    end
  end
end
