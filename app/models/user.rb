class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable,
         :recoverable, :rememberable, :trackable, :validatable

  LANGUAGES = [['English','en'], ['Русский','ru'], ['Українська','uk']]

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

  def vk_password=(value)
    connection_parameters['vk']['password'] = value
  end

  def vk_login=(value)
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

  %w(port domain address).each do |m|
    define_method m do
      email_parameters[m]
    end

    define_method "#{m}=" do |value|
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
    email_parameters['password'] = val
  end

  def email_name=(val)
    email_parameters['user_name'] = val
  end
end
