module ApiWrapper
  class VkFabric < BasicObject
    attr_reader :api, :login, :password, :app_id, :access_token

    def self.build(params)
      new(params).api
    end

    def initialize(params)
      @login = params['login']
      @password = params['password']
      @app_id = params['app_id']
      @access_token = params['access_token']
      @api ||= ::VK::Application.new do |a|
        a.app_id = app_id if app_id.present?
        a.access_token = access_token if access_token.present?
      end
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
      api.users.get
    rescue ::VK::APIError => e
      ::Rails.logger.debug("ApiError: #{e}")
      api.client_auth(login: login, password: password)
    end
  end
end