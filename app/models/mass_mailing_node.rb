class MassMailingNode < ActiveRecord::Base
  self.table_name = 'mass_mailings_nodes'
  self.inheritance_column = 'kind'

  belongs_to :node
  belongs_to :mass_mailing, dependent: :destroy

  validates :node, presence: true

  delegate :name, to: :node
  delegate :message, to: :mass_mailing

  scope :include_nested, -> { includes(:node, mass_mailing: :message) }

  def post?
    type == 'post'
  end
end
