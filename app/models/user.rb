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
    end
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

  def language_human
    Hash[User::LANGUAGES].invert[language]
  end
end
