class Group < ActiveRecord::Base
  include Errorable

  self.table_name = 'tags'
  has_many :taggings, foreign_key: 'tag_id'
  has_many :nodes, through: :taggings, source: :taggable, source_type: 'Node'

  accepts_nested_attributes_for :taggings, allow_destroy: true

  validates :taggings, length: { minimum: 1 }
  validates :name, length: { minimum: 3 }

  scope :groups, -> { joins(:taggings).where(taggings: { context: 'tags', taggable_type: 'Node' }).uniq }
end
