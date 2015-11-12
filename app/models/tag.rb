class Tag < ActiveRecord::Base
  has_many :taggings, foreign_key: 'tag_id'
  has_many :nodes, through: :taggings, source: :taggable, source_type: 'Node'

  scope :groups, -> { joins(:taggings).where(taggings: { context: 'groups' }) }
end
