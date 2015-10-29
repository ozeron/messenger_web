class MassMailing < ActiveRecord::Base
  belongs_to :message
  has_many :mass_mailing_nodes
  has_many :nodes, through: :mass_mailing_nodes

  #validate :at_least_one_mailing_node, :message_present?

  accepts_nested_attributes_for :mass_mailing_nodes

  def message_present?
    message.present?
  end

  def at_least_one_mailing_node
    errors.add(:base, 'must add at least one node') if self.mass_mailing_nodes.blank?
    true
  end
end
