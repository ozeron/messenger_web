class MassMailingsNode < ActiveRecord::Base
  belongs_to :node
  belongs_to :mass_mailing
end
