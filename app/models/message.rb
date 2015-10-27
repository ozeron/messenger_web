class Message < ActiveRecord::Base
  has_many :taggings, as: :taggable
  belongs_to :mass_mailing
  acts_as_taggable

  scope :includes_tags, -> { includes(:tags) }

  def self.search(query)
    # TODO: Fix search
    # additional_ids = NodeIdsWhereTagNameMatch.query(query).join(",")
    # where("title ILIKE :search OR content ILIKE :search OR ARRAY[id] <@ ARRAY[#{additional_ids}]::integer[]",
    #       search: "%#{query}%")
    where('title ILIKE :search OR content ILIKE :search', search: "%#{query}%")
  end
end
