class Account < ActiveRecord::Base
  has_many :mass_mailings

  after_initialize do
    if new_record?
      self.connection_parameters ||= {}
    end
  end

  before_save do
    self.connection_parameters ||= {}
  end

  after_update do
    if connection_parameters_changed?
      connection_parameters['vk']['access_token'] = ''
      set_vk_name
    end
  end

  def vk_login
    vk.login
  end

  def vk_password
    vk.password
  end

  def vk_app_id_full
    vk.app_id || VK.config.app_id
  end

  def vk_app_id
    vk.app_id
  end

  def vk_name
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

  def vk_password=(value)
    connection_parameters['vk'] ||= {}
    connection_parameters['vk']['password'] = value
  end

  def vk_app_id=(value)
    connection_parameters['vk'] ||= {}
    connection_parameters['vk']['app_id'] = value
  end

  def vk_login=(value)
    connection_parameters['vk'] ||= {}
    connection_parameters['vk']['login'] = value
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

  def email_name
    email_parameters['user_name']
  end

  def email_password=(val)
    connection_parameters['email'] ||= {}
    connection_parameters['email']['password'] = val
  end

  def email_name=(val)
    connection_parameters['email'] ||= {}
    connection_parameters['email']['user_name'] = val
  end
end
