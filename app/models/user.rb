class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  LANGUAGES = [['English','en'], ['Русский','ru'], ['Українська','uk']]

  validates :language,
            presence: true,
            inclusion: {in: LANGUAGES.map(&:second)}

  def vk_app
    @app ||= ApiWrapper::VkFabric.build(connection_parameters['vk'])
    if connection_parameters['vk']['access_token'] != @app.access_token
      connection_parameters['vk']['access_token'] = @app.access_token
      save
    end
    @app
  end
end
