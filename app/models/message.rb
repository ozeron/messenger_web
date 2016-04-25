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

  validates :title, presence: true
  validates :content, presence: true

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

  def load_attachments
    {}.tap do |hash|
      hash[pic1_name.to_s] = File.read(pic1_path) if pic1_exist?
      hash[doc1_name.to_s] = File.read(doc1_path) if doc1_exist?
    end
  end

  def tag_list_name
    tags.map(&:name).join('; ')
  end

  def pic1_exist?
    File.exist?(pic1_path)
  end

  def pic1_path
    attachment_path(pic1_file_name)
  end

  def doc1_path
    attachment_path(doc1_file_name)
  end

  def doc1_exist?
    File.exist?(doc1_path)
  end

  def attacments?
    doc1_exist? || pic1_exist?
  end

  def attachment_path(name)
    if name.present?
      "#{Rails.root.to_s}/public/images/attachments/#{name}"
    else
      ''
    end
  end
end
