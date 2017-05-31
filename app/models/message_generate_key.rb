class MessageGenerateKey
  include ActiveModel::Validations

  attr_accessor :key, :phone, :bool_is_good

  validates_format_of :phone, :with => /.?([0-9]{2})?.?([ -]?)([0-9]{2,3})([ -]?)([0-9]{3})([ -]?)([0-9]{3})/i

end