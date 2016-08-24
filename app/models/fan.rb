class Fan
  include Mongoid::Document
  field :_id, type: String
  field :properties, type: Hash

  attr_accessor :_id
  
  validates_with FanRequiredPropertiesValidator
end
