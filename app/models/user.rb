class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable,
         :recoverable, :rememberable, :trackable, :validatable

  LANGUAGES = [['English','en'], ['Русский','ru'], ['Українська','uk']]

  validates :language,
            presence: true,
            inclusion: { in: LANGUAGES.map(&:second) }

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

  def language_human
    Hash[User::LANGUAGES].invert[language]
  end
end
