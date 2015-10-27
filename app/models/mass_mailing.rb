class MassMailing < ActiveRecord::Base
  belongs_to :message
  has_many :mass_mailings_nodes
  has_and_belongs_to_many :nodes

  accepts_nested_attributes_for :mass_mailings_nodes
end
