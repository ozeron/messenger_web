class Node::Email < Node
  delegate :telephones, :address, :emails, :website, :city, to: :options
  def self.build(attributes)
    attributes['options'] = attributes.extract!('email') || {}
    new(attributes)
  end

  def email=(value)
    options['email'] = value
  end

  def email
    options.key?('email') ? options['email'] : options['emails'].first
  end

  def options
    return @options_mash if @options_mash
    @options_mash = Hashie::Mash.new(self['options'])
    @options_mash.default = ''
    @options_mash
  end

  def description
    ''.tap do |str|
      str.concat(self['description'] + "\n") if self['description']
      str.concat("тел. #{telephones.try(:join, ',')}\n") if telephones.present?
      str.concat("аддрес: #{address}\n") if address.present?
      str.concat("email: #{email}\n") if email.present?
      str.concat("website: #{website}\n") if website.present?
      str.concat("місто: #{city}\n") if city.present?
    end
  end
end
