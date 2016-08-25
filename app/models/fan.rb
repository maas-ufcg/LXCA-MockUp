Dir.glob('app/validators/fan*.rb').each do |f| 
  require_relative "../../#{f}"
end

class Fan
  include Mongoid::Document
  field :_id, type: String
  field :properties, type: Hash
  
  validates_with FanRequiredPropertiesValidator
  validates_with FanConsistencyValidator
end
