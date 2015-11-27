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

  def calculate_status
    case processed_node_counter
    when 0
      self.status = 'pending'
    when less_than_nodes_size
      self.status = 'in_progress'
    when equal_node_size
      calculate_success_or_not
    else
      fail "Undetermined status for #{processed_node_counter} and #{nodes.size}"
    end
  end

  def less_than_nodes_size
    -> (counter) { counter < nodes.size }
  end

  def equal_node_size
    -> (counter) { counter == nodes.size }
  end

  def include_only_error_and_success
    lambda do |array|
      array.size == 2 && array.include?('success') && array.include?('failed')
    end
  end

  def calculate_success_or_not
    children_statuses = mass_mailing_nodes.map(&:status).uniq
    case children_statuses
    when ['failed']
      self.status = 'failed'
      self.finished = Time.now
    when ['success']
      self.status = 'success'
      self.finished = Time.now
    when include_only_error_and_success
      self.status = 'warning'
    else
      fail "Undetermined MassMailing status #{children_statuses}"
    end
  end
end
