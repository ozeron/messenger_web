class Group < ActiveRecord::Base
  acts_as_tree order: :name
  has_many :node_groups
  has_many :nodes, through: :node_groups
  accepts_nested_attributes_for :node_groups, allow_destroy: true
end
