class Account < ActiveRecord::Base
  has_many :mass_mailings

  validates :vk_app_id, presence: true, if: :vk_config_present?
  validates :vk_access_token, presence: true, if: :vk_config_present?

  validates :email_name, presence: true, if: :email_config_present?
  validates :email_password, presence: true, if: :email_config_present?
  validates :domain, presence: true, if: :email_config_present?
  validates :address, presence: true, if: :email_config_present?

  after_initialize do
    if new_record?
      self.connection_parameters ||= {}
    end
  end

  before_save do
    self.connection_parameters ||= {}
  end

  after_update do
    if connection_parameters_changed? && vk_config_present?
      #connection_parameters['vk']['access_token'] = ''
      set_vk_name
    end
  end

  def vk_app_id_full
    vk.app_id || VK.config.app_id
  end

  def vk_access_token
    vk.access_token
  end

  def vk_app_id
    vk.app_id
  end

  def vk_name
    return 'VK not connected' unless vk_config_present?
    return vk['name'] if vk.key?('name')
    name = set_vk_name
    save
    name
  end

  def set_vk_name
    hash = get_vk_app.users.get[0]
    name = "#{hash['first_name']} #{hash['last_name']}"
    connection_parameters['vk']['name'] = name
  end

  def connection_parameters
    self['connection_parameters'] ||= {}
  end

  def vk_app_id=(value)
    connection_parameters['vk'] ||= {}
    connection_parameters['vk']['app_id'] = value
  end

  def vk_access_token=(value)
    connection_parameters['vk'] ||= {}
    connection_parameters['vk']['access_token'] = value
  end

  def vk_app
    @app ||= get_vk_app
    if connection_parameters['vk']['access_token'] != @app.access_token
      connection_parameters['vk']['access_token'] = @app.access_token
      save
    end
    @app
  end

  def get_vk_app
    ApiWrapper::VkFabric.build(connection_parameters['vk'])
  end

  def vk
    Hashie::Mash.new connection_parameters.fetch('vk', {})
  end

  def email_config
    Hashie::Mash.new email_parameters
  end

  def email_parameters
    connection_parameters.fetch('email', {})
  end

  %w(port domain address enable_starttls_auto ssl tls authentication).each do |m|
    define_method m do
      email_parameters[m]
    end

    define_method "#{m}=" do |value|
      connection_parameters['email'] ||= {}
      connection_parameters['email'][m] = value
    end
  end

  def email_password
    email_parameters['password']
  end

  def email_full_name
    email_parameters['user_name'] || 'Email not connected'
  end

  def email_name
    email_parameters['user_name']
  end

  def email_password=(val)
    connection_parameters['email'] ||= {}
    connection_parameters['email']['password'] = val
  end

  def email_name=(val)
    connection_parameters['email'] ||= {}
    connection_parameters['email']['user_name'] = val if val != 'Email not connected'
  end

  private

  def vk_config_present?
    vk_app_id.present? || vk_access_token.present?
  end

  def email_config_present?
    (email_name.present? && email_name != 'Email not connected') ||
      email_password.present?
  end
end
