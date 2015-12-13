class Node < ActiveRecord::Base
  has_many :taggings, as: :taggable
  has_many :mass_mailing_nodes
  has_and_belongs_to_many :mass_mailings
  acts_as_taggable
  acts_as_taggable_on :groups

  scope :includes_tags, -> { includes(:tags) }
  scope :with_tags, -> { includes(:tags) }

  def self.search(query)
    additional_ids = NodeIdsWhereTagNameMatch.query(query).join(",")
    where("name ILIKE :search OR description ILIKE :search OR ARRAY[id] <@ ARRAY[#{additional_ids}]::integer[]",
          search: "%#{query}%")

  end

  def self.build(attributes)
    new(attributes)
  end

  def self.types
    %w(Node::Vk Node::Email)
  end

  def tag_list_name
    tags.map(&:name).join('; ')
  end

  def human
    "#{id} #{name}"
  end
end
