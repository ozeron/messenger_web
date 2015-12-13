class Tagging < ActiveRecord::Base
  belongs_to :group, foreign_key: :tag_id
  belongs_to :taggable, polymorphic: true

  scope :nodes, -> { where(taggable_type: 'Node').includes(:taggable).uniq { h.taggable_id } }
  def human
    taggable.human
  end
end
