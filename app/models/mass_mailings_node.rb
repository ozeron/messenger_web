class MassMailingsNode < ActiveRecord::Base
  belongs_to :node
  belongs_to :mass_mailing

  validates :node, presence: true
  validates :mass_mailing, presence: true
end
