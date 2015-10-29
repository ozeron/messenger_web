class MassMailingNode < ActiveRecord::Base
  self.table_name = 'mass_mailings_nodes'

  belongs_to :node
  belongs_to :mass_mailing

  validates :node, presence: true
end
