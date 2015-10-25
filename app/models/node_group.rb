class NodeGroup < ActiveRecord::Base
  belongs_to :node
  belongs_to :group
end
