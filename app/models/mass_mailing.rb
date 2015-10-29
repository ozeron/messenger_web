class MassMailing < ActiveRecord::Base
  belongs_to :message
  has_many :mass_mailings_nodes
  has_and_belongs_to_many :nodes

  validates :message, presence: true
  validate :has_mailings_node

  def has_mailings_node
    errors.add(:base, 'must add at least one node') if self.mass_mailings_nodes.blank?
  end

  accepts_nested_attributes_for :mass_mailings_nodes
end
