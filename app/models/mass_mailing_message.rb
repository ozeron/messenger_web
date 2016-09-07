class MassMailingMessage < ActiveRecord::Base
  belongs_to :mass_mailing
  belongs_to :message
end
