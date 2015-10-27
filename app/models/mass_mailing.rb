class MassMailing < ActiveRecord::Base
  belongs_to :message
  has_many :mass_mailing_nodes
  has_many :nodes, through: :mass_mailing_nodes

  validates :message, presence: true
  validate :has_mailings_node

  def has_mailings_node
    errors.add(:base, 'must add at least one node') if self.mass_mailings_nodes.blank?
  end

  accepts_nested_attributes_for :mass_mailing_nodes
end
