class MassMailing < ActiveRecord::Base
  include Errorable
  has_many :mass_mailing_nodes, dependent: :destroy
  has_many :nodes, through: :mass_mailing_nodes
  has_many :mass_mailing_messages, dependent: :destroy
  has_many :messages, through: :mass_mailing_messages
  belongs_to :sender, class_name: "Account"


  before_create { self.started = Time.now }
  enum status: {
    'success' => 'success',
    'pending' => 'pending',
    'failed' => 'failed',
    'in_progress' => 'in_progress',
    'warning' => 'warning'
  }

  #validate :at_least_one_mailing_node, :message_present?

  accepts_nested_attributes_for :mass_mailing_nodes
  accepts_nested_attributes_for :mass_mailing_messages

  validates :title, length: { minimum: 3 }
#  validates :message_id, presence: true
  validates :mass_mailing_nodes, length: { minimum: 1 }
  validates :mass_mailing_messages, length: { minimum: 1 }

  def message_present?
    message.present?
  end

  def message
    messages.sample
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
      self.status = 'failed'
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
