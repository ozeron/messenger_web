class MassMailing < ActiveRecord::Base
  belongs_to :message
  has_and_belongs_to_many :nodes
end
