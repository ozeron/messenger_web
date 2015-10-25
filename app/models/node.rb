class Node < ActiveRecord::Base
  acts_as_taggable

  def self.build(attributes)
    new(attributes)
  end

  def self.types
    %w(Node::Vk Node::Email)
  end
end
