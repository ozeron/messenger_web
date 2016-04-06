class Message < ActiveRecord::Base
  #attr_reader :pic1_remote
  #attr_reader :pic1_file_name
  has_many :taggings, as: :taggable
  belongs_to :mass_mailing, dependent: :destroy
  acts_as_taggable
  has_attached_file :pic1, path: ":rails_root/public/images/attachments/:filename"
  has_attached_file :doc1, path: ":rails_root/public/docs/attachments/:filename"
  validates_attachment :pic1, pic1_content_type: ["image/jpeg", "image/gif", "image/png"]
  validates_attachment_file_name :pic1, matches: [/png\Z/, /jpe?g\Z/]

  #validates_attachment_content_type :pic1, content_type: /\Aimage\/.*\Z/
  #validates_attachment :pic1, pic1_file_name: matches: [/png\Z/, /jpe?g\Z/]#["image/jpeg", "image/gif", "image/png"]

  scope :includes_tags, -> { includes(:tags) }


  def self.search(query)
    # TODO: Fix search
    # additional_ids = NodeIdsWhereTagNameMatch.query(query).join(",")
    # where("title ILIKE :search OR content ILIKE :search OR ARRAY[id] <@ ARRAY[#{additional_ids}]::integer[]",
    #       search: "%#{query}%")
    where('title ILIKE :search OR content ILIKE :search', search: "%#{query}%")
  end
# Will be corrected to enable attachment from remote
=begin  
   def pic1_remote=(url)

    @pic1_remote = url
    self.pic1 = URI.parse(url)
    byebug
    self.pic1 = URI.parse(url)
  end
=end

  def tag_list_name
    tags.map(&:name).join('; ')
  end
end
