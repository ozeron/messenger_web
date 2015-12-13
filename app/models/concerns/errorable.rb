module Errorable
  extend ActiveSupport::Concern

  def human_errors
    validate
    return nil unless errors.messages.present?
    array = errors.messages.map do |attr, mes|
      "#{self.class.human_attribute_name(attr)}: #{mes.join(', ')}"
    end
    array.join("\n")
  end
end
