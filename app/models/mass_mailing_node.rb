class MassMailingNode < ActiveRecord::Base
  self.table_name = 'mass_mailings_nodes'

  belongs_to :node
  belongs_to :mass_mailing

  validates :node, presence: true

  delegate :name, to: :node
  delegate :message, to: :mass_mailing

  scope :include_nested, -> { includes(:node, mass_mailing: :message) }
end
