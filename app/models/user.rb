class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable,
         :recoverable, :rememberable, :trackable, :validatable

  LANGUAGES = [['English','en'], ['Русский','ru'], ['Українська','uk']]
  AUTHENTICATIONS = [['plain','plain'], ['login','login'], ['cram_md5','cram_md5']]

  after_initialize do
    if new_record?
      self.permission ||= 'user'
      self.connection_parameters ||= {}
    end
  end

  before_save do
    self.connection_parameters ||= {}
  end

  rails_admin do
    create do
      exclude_fields :reset_password_sent_at, :remember_created_at, :sign_in_count,
        :current_sign_in_at, :last_sign_in_at, :current_sign_in_ip, :last_sign_in_ip
    end
    edit do
      exclude_fields :reset_password_sent_at, :remember_created_at, :sign_in_count,
        :current_sign_in_at, :last_sign_in_at, :current_sign_in_ip, :last_sign_in_ip
    end

    list do
      field :id
      field :email
      field :last_sign_in_at
      field :language
      field :permission
    end
  end

  validates :language,
            presence: true,
            inclusion: { in: LANGUAGES.map(&:second) }

  enum permission: {
    'user' => 'user',
    'moderator' => 'moderator',
    'admin' => 'admin'
  }

  def vk_login
    vk.login
  end

  def vk_password
    vk.password
  end

  def vk_app_id
    vk.app_id
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
    @app ||= ApiWrapper::VkFabric.build(connection_parameters['vk'])
    if connection_parameters['vk']['access_token'] != @app.access_token
      connection_parameters['vk']['access_token'] = @app.access_token
      save
    end
    @app
  end

  def vk
    Hashie::Mash.new connection_parameters.fetch('vk', {})
  end

  def email_config
    Hashie::Mash.new email_parameters
  end

  def language_human
    Hash[User::LANGUAGES].invert[language]
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
