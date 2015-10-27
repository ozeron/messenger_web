class Node < ActiveRecord::Base
  has_many :taggings, as: :taggable
  has_many :mass_mailing_node
  has_and_belongs_to_many :mass_mailings
  acts_as_taggable

  scope :includes_tags, -> { includes(:tags) }

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
end
