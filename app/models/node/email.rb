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
    self['description'] + "\n" +
    "тел. #{telephones.try(:join, ',')}\nаддрес: #{address}\nemail: #{email}\nwebsite: #{website}\nмісто: #{city}".html_safe
  end
end
